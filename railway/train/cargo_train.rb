require_relative './train'

# class documentation
class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
  end
end
