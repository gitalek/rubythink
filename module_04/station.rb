class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def recieve(train)
    @trains << train
  end

  def send(train)
    @trains.delete(train)
  end

  def typed_train_list(type)
    amount = 0
    @trains.reduce(amount) { |acc, train| train.type == type ? acc += 1 : acc }
  end
end
