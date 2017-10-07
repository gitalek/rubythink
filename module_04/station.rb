class Station
  def initialize(name)
    @name = name
  end

  def recieve_train(train)
    @trains[train.number] = train
  end

  def send_train(train_number)
    @trains.delete(train_number)
  end

  def train_list
    @trains
  end

  def typed_train_list
    @trains.reduce(Hash.new(0)) { |list, train| list[train.type] += 1 }
  end
end
