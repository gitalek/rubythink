require_relative('./railcar')

# class documentation
class CargoRailcar < Railcar
  def initialize
    @type = 'cargo'
  end
end
