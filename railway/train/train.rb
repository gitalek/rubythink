require_relative('../modules/brand')
require_relative('../modules/instance_counter')

# class documentation
class Train
  include Brand
  attr_reader :number, :speed, :railcars, :type

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/i

  def initialize(number)
    @number = number
    validate!
    @railcars = []

    @speed = 0

    @@trains[number] = self
  end

  # interface method
  def valid?
    validate!
  rescue RuntimeError
    false
  end

  # interface method
  def each(&block)
    @railcars.each block
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

    @@trains << self
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

  # class variables
  @@trains = {}
  # @@instance_counter = 0

  # class methods
  def self.find(number)
    @@trains[number]
  end

  protected

  def validate!
    raise 'Wrong number format' if number !~ NUMBER_FORMAT
    true
  end
end
