class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_transitional_station(station)
    @stations.insert(-2, station)
  end

  def remove_transitional_station(station)
    @transional_stations.delete(station)
  end
end
