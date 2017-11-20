require 'minitest/autorun'
require_relative '../train/cargo_train'
require_relative '../train/passenger_train'

# class documentation
class TestCargoTrain < Minitest::Test
  def test_self_find_method
    train1 = CargoTrain.new('111-aa')
    train2 = CargoTrain.new('222-bb')
    train3 = PassengerTrain.new('333cc')
    train4 = PassengerTrain.new('444dd')

    assert_equal(train1, Train.find('111-aa'))
    assert_equal(train2, Train.find('222-bb'))
    assert_equal(train3, Train.find('333cc'))
    assert_equal(train4, Train.find('444dd'))
    assert_nil(Train.find('wrong_number'))
    assert_nil(Train.find(111))
  end

  def test_validate_method
    exception = assert_raises RuntimeError do
      CargoTrain.new('123')
    end

    assert_equal('Wrong number format', exception.message)

    train = PassengerTrain.new('555-ee')
    assert(train.valid?)
  end
end
