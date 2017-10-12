require_relative './train'

# class documentation
class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = 'passenger'
  end
end
