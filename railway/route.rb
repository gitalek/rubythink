# class documentation
class Route
  # interface method
  attr_reader :stations

  def initialize(start_station, end_station)
    validate! start_station, end_station
    @stations = [start_station, end_station]
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

  def validate!(start_station, end_station)
    raise 'First argument must be instant of Station class!' unless start_station.instance_of? Station

    raise 'Second argument must be instant of Station class!' unless end_station.instance_of? Station

    true
  end
end
