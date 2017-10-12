require_relative './train'

# class documentation
class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = 'cargo'
  end
end
