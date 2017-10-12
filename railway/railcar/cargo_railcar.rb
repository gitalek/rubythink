require_relative('./railcar')

# class documentation
class CargoRailcar < Railcar
  attr_reader :type

  def initialize
    @type = 'cargo'
  end
end
