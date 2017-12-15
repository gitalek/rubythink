require_relative('./railcar')

# class documentation
class CargoRailcar < Railcar
  attr_reader :total_volume, :takken_volume

  def initialize(volume)
    validate_volume! volume

    super()

    @type = 'cargo'

    @total_volume = volume
    @takken_volume = 0
  end

  def take_a_volume(volume = 0)
    validate_volume! volume

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

  protected

  def validate_volume!(volume)
    raise 'volume must be a Number' unless volume.is_a? Numeric
    true
  end
end
