require 'minitest/autorun'
require_relative '../railcar/passenger_railcar'

# class documentation
class TestPassengerRailcar < Minitest::Test
  def setup
    seating_capacity = 3
    @railcar = PassengerRailcar.new(seating_capacity)
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

  def test_capacity
    assert_equal(3, @railcar.seating_capacity)
    assert_equal(0, @railcar.takken_seats)
    assert_equal(3, @railcar.free_seats)
    @railcar.take_a_seat
    assert_equal(1, @railcar.takken_seats)
    assert_equal(2, @railcar.free_seats)
    @railcar.take_a_seat
    @railcar.take_a_seat
    assert_equal(3, @railcar.takken_seats)
    assert_equal(0, @railcar.free_seats)

    assert_equal(false, @railcar.take_a_seat)
    assert_equal(3, @railcar.takken_seats)
    assert_equal(0, @railcar.free_seats)
  end
end
