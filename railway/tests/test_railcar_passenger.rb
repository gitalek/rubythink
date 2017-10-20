require 'minitest/autorun'
require_relative '../railcar/passenger_railcar'

# class documentation
class TestPassengerRailcar < Minitest::Test
  def setup
    @railcar = PassengerRailcar.new
  end

  def test_brand_mixin
    name = 'VagonMash'
    @railcar.brand = name

    assert_equal(name, @railcar.brand)

    name2 = 'StroyVagon'
    @railcar.brand = name2

    assert_equal(name2, @railcar.brand)
  end

  def test_type_property
    type = 'passenger'
    assert_equal(type, @railcar.type)
  end
end
