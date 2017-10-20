require_relative('../modules/brand')

# class documentation
class Railcar
  include Brand
  attr_reader :type
end
