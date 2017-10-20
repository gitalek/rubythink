require_relative('./railcar')

# class documentation
class PassengerRailcar < Railcar
  def initialize
    @type = 'passenger'
  end
end
