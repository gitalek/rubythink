# class documentation
class Route
  # interface method
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
  end

  # interface method
  def add_transitional_station(station)
    @stations.insert(-2, station)
  end

  # interface method
  def remove_transitional_station(station)
    @stations.delete(station)
  end

  protected

  def validate!
    raise 'First argument must be instant of Station class!' unless stations.first.instance_of? Station

    raise 'Second argument must be instant of Station class!' unless stations.last.instance_of? Station

    true
  end
end
