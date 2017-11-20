class Station
  # interface method
  attr_reader :trains, :name

  NAME_FORMAT = /\w{3,}/

  def initialize(name)
    @name = name
    validate!
    @trains = []

    @@stations << self
  end

  def valid?
    validate!
  rescue RuntimeError
    false
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

  protected

  def validate!
    raise 'Wrong name format' if name !~ NAME_FORMAT
    true
  end
end
