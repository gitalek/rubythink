require_relative('../modules/brand')

# class documentation
class Railcar
  include Brand

  attr_reader :type, :number

  def initialize
    @@instance_counter += 1
    @number = @@instance_counter
  end

  # class variables
  @@instance_counter = 0
end
