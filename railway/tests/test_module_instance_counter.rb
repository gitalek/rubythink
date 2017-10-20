require 'minitest/autorun'
# require_relative '../modules/instance_counter.rb'
require_relative './assets/example.rb'

# class documentation
class TestStation < Minitest::Test
  def test_module
    Example.new
    assert_equal(1, Example.counter)

    Example.new
    Example.new
    assert_equal(3, Example.instances)

    Example.new
    Example.new
    Example.new
    Example.new
    assert_equal(7, Example.instances)
  end
end
