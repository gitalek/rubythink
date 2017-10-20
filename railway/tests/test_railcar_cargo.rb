require 'minitest/autorun'
require_relative '../railcar/cargo_railcar'

# class documentation
class TestCargoRailcar < Minitest::Test
  def setup
    @railcar = CargoRailcar.new
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
end
