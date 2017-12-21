require_relative('../modules/accessors')
require_relative('../modules/validation')
require_relative('../modules/brand')

# class documentation
class Railcar
  class << self
    attr_accessor :instance_counter
  end

  include Accessors
  include Validation
  include Brand

  attr_reader :type, :number

  def initialize
    self.class.superclass.instance_counter += 1
    @number = self.class.superclass.instance_counter
  end

  # class variables
  @instance_counter = 0
end
