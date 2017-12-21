require_relative('../modules/accessors')
require_relative('../modules/validation')

# class documentation
class Station
  class << self
    attr_reader :stations
  end

  include Accessors
  include Validation

  # interface method
  attr_reader :trains, :name

  NAME_FORMAT = /^.{3,}$/

  def initialize(name)
    @name = name
    validate!
    @trains = []

    self.class.stations << self
  end

  def each_train(block)
    @trains.each(&block)
  end

  # interface method
  def recieve(train)
    @trains << train
  end

  # interface method
  def send(train)
    @trains.delete(train)
  end

  # interface method
  def typed_train_list(type)
    amount = 0
    @trains.reduce(amount) { |acc, train| train.type == type ? acc + 1 : acc }
  end

  # class varibles
  @stations = []

  # class methods
  def self.all
    @stations
  end
end
