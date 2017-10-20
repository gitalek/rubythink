require_relative './train'

# class documentation
class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'passenger'
  end
end
