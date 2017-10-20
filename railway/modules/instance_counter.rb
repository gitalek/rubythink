# module documentation
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # module documentation
  module ClassMethods
    attr_accessor :counter

    def instances
      counter
    end

    def increase_counter
      self.counter ||= 0
      self.counter += 1
    end
  end

  # module documentation
  module InstanceMethods
    protected

    def register_instance
      self.class.increase_counter
    end
  end
end
