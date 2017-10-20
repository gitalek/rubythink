require_relative('../../modules/instance_counter')

# class documentation
class Example
  include InstanceCounter

  def initialize
    register_instance
  end
end
