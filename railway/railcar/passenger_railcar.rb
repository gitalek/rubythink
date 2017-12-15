require_relative('./railcar')

# class documentation
class PassengerRailcar < Railcar
  attr_reader :seating_capacity, :takken_seats

  def initialize(seats)
    validate_seats! seats

    super()

    @type = 'passenger'

    @seating_capacity = seats
    @takken_seats = 0
  end

  def take_a_seat
    if free_seats > 0
      @takken_seats += 1
      true
    else
      puts 'Свободные места закончились :('
      false
    end
  end

  def free_seats
    @seating_capacity - @takken_seats
  end

  protected

  def validate_seats!(seats)
    raise 'seats must be a Number' unless seats.is_a? Numeric
    true
  end
end
