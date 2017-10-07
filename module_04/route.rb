class Route
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @transional_stations = []
  end

  def add_transitional_station(station)
    @transional_stations << station
  end

  def remove_transitional_station(station)
    @transional_stations.delete(station)
  end

  def print_route
    puts @start_station
    @transional_stations.each { |station| puts station.name }
    puts @end_station
  end
end
