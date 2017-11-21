require 'minitest/autorun'
require_relative '../railcar/cargo_railcar'

# class documentation
class TestCargoRailcar < Minitest::Test
  def setup
    @railcar = CargoRailcar.new(100)
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
    type = 'cargo'
    assert_equal(type, @railcar.type)
  end

  def test_capacity
    assert_equal(100, @railcar.total_volume)
    assert_equal(0, @railcar.takken_volume)
    assert_equal(100, @railcar.free_volume)
    @railcar.take_a_volume(55)
    assert_equal(55, @railcar.takken_volume)
    assert_equal(45, @railcar.free_volume)
    @railcar.take_a_volume(23)
    @railcar.take_a_volume(12)
    assert_equal(90, @railcar.takken_volume)
    assert_equal(10, @railcar.free_volume)

    assert_equal(false, @railcar.take_a_volume(11))
    assert_equal(90, @railcar.takken_volume)
    assert_equal(10, @railcar.free_volume)
  end
end
