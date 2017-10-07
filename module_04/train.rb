class Train
  attr_reader :speed
  attr_reader :railcar_amount
  attr_writer :route

  def initialize(number, type, railcar_amount)
    @number = number
    @type = type
    @railcar_amount = railcar_amount
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end
end
