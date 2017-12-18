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
    train1 = CargoTrain.new('111-aa')
    train2 = PassengerTrain.new('222-bb')
    @station.recieve(train1)
    @station.recieve(train2)

    assert_equal([train1, train2], @station.trains)

    @station.send(train2)
    assert_equal([train1], @station.trains)
  end

  def test_validate_method
    exception = assert_raises RuntimeError do
      name = 'kz'
      Station.new(name)
    end
    assert_equal('kz - wrong name format', exception.message)

    station = Station.new('eee-ee')
    assert(station.valid?)
  end

  # update this test when previous tests were changed or added
  # def test_self_all_method
  #   assert_equal(1, Station.all.length)
  #   assert_includes(Station.all, @station)
  #   Station.new('msk')
  #   Station.new('spb')
  #   assert_equal(4, Station.all.length)
  # end
end
