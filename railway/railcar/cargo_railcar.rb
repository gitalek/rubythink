require_relative('./railcar')

# class documentation
class CargoRailcar < Railcar
  attr_reader :total_volume, :takken_volume
  def initialize(volume)
    @type = 'cargo'

    @total_volume = volume
    @takken_volume = 0
  end

  def take_a_volume(volume)
    if free_volume >= volume
      @takken_volume += volume
      true
    else
      puts 'Нет свободного объёма :('
      false
    end
  end

  def free_volume
    @total_volume - @takken_volume
  end
end
