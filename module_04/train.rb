class Train
  attr_reader :speed, :railcar_amount, :type

  def initialize(number, type, railcar_amount)
    @number = number
    @type = type
    @railcar_amount = railcar_amount

    @speed = 0
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def attach_railcar
    @railcar_amount += 1 if @speed.zero?
  end

  def detach_railcar
    @railcar_amount -= 1 if @speed.zero? && @railcar_amount > 0
  end

  def route=(route)
    @route = route
    @station_number = 0
  end

  def move_forward
    if @station_number == @route.stations.length
      return
    end

    @route.stations[@station_number].send(self)
    @station_number += 1
    @route.stations[@station_number].receive(self)
  end

  def move_bacward
    if @station_number == @route.stations.length || @station_number.zero?
      return
    end

    @route.stations[@station_number].send(self)
    @station_number -= 1
    @route.stations[@station_number].receive(self)
  end

  def current_station
    @station_number[@station_number]
  end

  def next_station
    @route.stations[@station_number + 1]
  end

  def previous_station
    @route.stations[@station_number - 1]
  end
end
