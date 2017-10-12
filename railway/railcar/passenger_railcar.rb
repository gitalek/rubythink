require_relative('./railcar')

# class documentation
class PassengerRailcar < Railcar
  attr_reader :type

  def initialize
    @type = 'passenger'
  end
end
