# class documentation
class Route
  # interface method
  attr_reader :stations

  def initialize(start_station, end_station)
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
end
