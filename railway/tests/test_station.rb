require 'minitest/autorun'
require_relative '../station'
require_relative '../train/cargo_train'
require_relative '../train/passenger_train'

# class documentation
class TestStation < Minitest::Test
  def setup
    name = 'vld'
    @station = Station.new(name)

    assert_equal(name, @station.name)
    assert_empty(@station.trains)
  end

  def test_train_interaction
    train1 = CargoTrain.new(1)
    train2 = PassengerTrain.new(1)
    @station.recieve(train1)
    @station.recieve(train2)

    assert_equal([train1, train2], @station.trains)

    @station.send(train2)
    assert_equal([train1], @station.trains)
  end

  # update this test if previous tests were changed or added
  def test_self_all_method
    assert_equal(1, Station.all.length)
    assert_includes(Station.all, @station)
    Station.new('msk')
    Station.new('spb')
    assert_equal(3, Station.all.length)
  end
end
