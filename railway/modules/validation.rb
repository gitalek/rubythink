# module documentation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # module documentation
  module ClassMethods
    def validate(attribute, *options)
      raise TypeError, 'Symbol is needed' unless attribute.is_a? Symbol
      validates_attribute_name = :@validates

      if instance_variable_defined?(validates_attribute_name)
        instance_variable_get(validates_attribute_name)[attribute] = options
      else
        instance_variable_set(validates_attribute_name, attribute => options)
      end
    end
  end

  # module documentation
  module InstanceMethods
    def validate_presence(value, _)
      raise 'nil or empty value' if value.nil? || value.empty?
      true
    end

    def validate_format(value, format)
      raise 'value is not matching format' unless value.to_s =~ format
      true
    end

    def validate_type(value, type)
      raise 'wrong value class' unless value.is_a? type
      true
    end

    def validate!
      self.class.instance_variable_get(:@validates).each do |attribute, options|
        value = instance_variable_get("@#{attribute}".to_sym)
        send("validate_#{options[0]}", value, options[1])
      end
      true
    end

    def valid!
      validate!
    rescue RuntimeError
      false
    end
    true
  end
end
