require 'minitest/autorun'
require_relative '../train/cargo_train'
require_relative '../train/passenger_train'

# class documentation
class TestCargoTrain < Minitest::Test
  def test_self_find_method
    train1 = CargoTrain.new(1)
    train2 = CargoTrain.new(2)
    train3 = PassengerTrain.new('third')
    train4 = PassengerTrain.new('fourth')

    assert_equal(train1, Train.find(1))
    assert_equal(train2, Train.find(2))
    assert_equal(train3, Train.find('third'))
    assert_equal(train4, Train.find('fourth'))
    assert_nil(Train.find('wrong_number'))
    assert_nil(Train.find(111))
  end
end
