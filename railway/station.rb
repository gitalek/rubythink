class Station
  # interface method
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []

    @@stations << self
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
    @trains.reduce(amount) { |acc, train| train.type == type ? acc += 1 : acc }
  end

  # class varibles
  @@stations = []

  # class methods
  def self.all
    @@stations
  end
end
