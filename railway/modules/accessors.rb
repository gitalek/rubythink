# module documentation
module Accessors
  def symbol_validate!(value)
    raise 'Symbol is needed' unless value.is_a? Symbol
  end

  def define_setter(attribute, attribute_name)
    define_method(attribute) { instance_variable_get(attribute_name) }
  end

  def define_getter(attribute, attribute_name)
    define_method("#{attribute}=".to_sym) do |value|
      instance_variable_set(attribute_name, value)
      send("#{attribute}_history") << value
    end
  end

  def define_history_attribute(attribute, attribute_name)
    define_method("#{attribute}_history".to_sym) do
      instance_variable_get(attribute_name) || instance_variable_set(attribute_name, [])
    end
  end

  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      symbol_validate!(attribute)

      attribute_name = "@#{attribute}".to_sym
      attribute_history_name = "@#{attribute}_history"

      define_setter(attribute, attribute_name)
      define_getter(attribute, attribute_name)
      define_history_attribute(attribute, attribute_history_name)
    end
  end

  def strong_attr_accessor(attribute, type)
    raise 'Symbol is needed' unless attribute.is_a? Symbol

    attribute_name = "@#{attribute}".to_sym

    define_method(attribute) { instance_variable_get(attribute_name) }

    define_method("#{attribute}=".to_sym) do |value|
      raise "#{type} is needed, #{value.class} is given" unless value.is_a? type
      instance_variable_set(attribute_name, value)
    end
  end
end
