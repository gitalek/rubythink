# class documentation
class Train
  attr_reader :number, :speed, :railcars

  def initialize(number)
    @number = number
    @railcars = []

    @speed = 0
  end

  # interface method
  def speed_up
    @speed += 10
  end

  # interface method
  def stop
    @speed = 0
  end

  # interface method
  def attach_railcar(railcar)
    @railcars << railcar if @type == railcar.type && @speed.zero?
  end

  # interface method
  def detach_railcar(railcar)
    @railcars.delete(railcar) if @speed.zero? && !@railcars.zero?
  end

  # interface method
  def route=(route)
    @route = route
    @station_number = 0
  end

  # interface method
  def move_forward
    return if @station_number == @route.stations.length

    current_station.send(self)
    next_station.recieve(self)
    @station_number += 1
  end

  # interface method
  def move_bacward
    return if @station_number == @route.stations.length || @station_number.zero?

    current_station.send(self)
    next_station.recieve(self)
    @station_number -= 1
  end

  # interface method
  def current_station
    @route.stations[@station_number]
  end

  # interface method
  def next_station
    @route.stations[@station_number + 1]
  end

  # interface method
  def previous_station
    @route.stations[@station_number - 1]
  end
end
