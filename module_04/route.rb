class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = []
    @stations.unshift(start_station)
    @stations.push(end_station)
  end

  def add_transitional_station(station)
    @stations.insert(@stations.length - 2, station)
  end

  def remove_transitional_station(station)
    @transional_stations.delete(station)
  end
end
