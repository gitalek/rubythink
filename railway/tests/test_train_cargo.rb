require 'minitest/autorun'
require_relative '../train/cargo_train'

# class documentation
class TestCargoTrain < Minitest::Test
  def setup
    number = 1
    @train = CargoTrain.new(number)

    assert_equal(number, @train.number)
    assert_equal(0, @train.speed)
    assert_empty(@train.railcars)
    type = 'cargo'
    assert_equal(type, @train.type)
  end

  def test_brand_mixin
    name = 'VagonMash'
    @train.brand = name

    assert_equal(name, @train.brand)

    name2 = 'StroyVagon'
    @train.brand = name2

    assert_equal(name2, @train.brand)
  end

  def test_speed
    @train.speed_up
    assert_equal(10, @train.speed)

    @train.stop
    assert_equal(0, @train.speed)

    @train.speed_up
    @train.speed_up
    assert_equal(20, @train.speed)
  end

  def test_self_find_method
    assert_equal(@train, Train.find(1))
  end
end
