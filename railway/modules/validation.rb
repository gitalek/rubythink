# module documentation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # module documentation
  module ClassMethods
    def validates
      @validates ||= []
    end

    def validate(attribute, *options)
      raise TypeError, 'Symbol or String is needed' unless attribute.is_a?(Symbol) || attribute.is_a?(String)

      validation_type, additional_data = options
      validate_set = { attribute: attribute, validation_type: validation_type, additional_data: additional_data }
      validates << validate_set
    end
  end

  # module documentation
  module InstanceMethods
    def validate!
      self.class.validates.each do |validate|
        value = instance_variable_get("@#{validate.attribute}".to_sym)
        send("validate_#{validate.validation_type}", value, validate.additional_data)
      end
      true
    end

    def valid!
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def validate_presence(value, _)
      raise 'nil or empty value' if value.nil? || value.empty?
    end

    def validate_format(value, format)
      raise 'value is not matching format' unless value.to_s =~ format
    end

    def validate_type(value, type)
      raise 'wrong value class' unless value.is_a? type
    end
  end
end
