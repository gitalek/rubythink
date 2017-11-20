require 'minitest/autorun'
require_relative '../route'
require_relative '../station'
# require_relative '../train/cargo_train'
# require_relative '../train/passenger_train'

# class documentation
class TestStation < Minitest::Test
  def test_validate_method
    start_station = Station.new('vld')
    end_station = Station.new('msk')

    exception = assert_raises RuntimeError do
      Route.new('start_station', end_station)
    end
    assert_equal('First argument must be instant of Station class!', exception.message)

    exception = assert_raises RuntimeError do
      Route.new(start_station, 1234)
    end
    assert_equal('Second argument must be instant of Station class!', exception.message)
  end
end
