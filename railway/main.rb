require_relative 'station'
require_relative 'train/cargo_train'
require_relative 'train/passenger_train'
require_relative 'route'
require_relative 'railcar/cargo_railcar'
require_relative 'railcar/passenger_railcar'

$stations = {}
$trains = {}
$routes = {}

$trainClassFromType = {
  'cargo' => CargoTrain,
  'passenger' => PassengerTrain
}

def show_menu
  input_message = <<-HEREDOC

  Menu:

  0 - show this menu
  -------------------------------------------------------
  1 - create station  10 - show list of created stations
  -------------------------------------------------------
  2 - create train    20 - show list of created trains
                      21 - show list of trains on station
                      22 - set route to train
                      23 - attach railcar to train
                      24 - detach railcar from train
                      25 - move train backward
                      26 - move train forward
  -------------------------------------------------------
  3 - create route    30 - show list of created routes
                      31 - show list of stations in route
                      32 - add station to route
                      33 - remove station from route
  -------------------------------------------------------
  9 - exit

  HEREDOC

  puts input_message
end

def input(request)
  print request
  response = gets.chomp
  response
end

def get_station(request = 'Enter name of station: ')
  station = input(request)
  $stations[station]
end

def get_train(request = 'Enter number of train: ')
  train_number = input(request).to_i
  $trains[train_number]
end

def get_route(request = 'Enter name of route: ')
  route = input(request)
  $routes[route]
end

def create_station
  puts 'CREATING THE STATION...'
  name = input('Enter name of station: ')

  station = Station.new(name)
  $stations[name] = station

  puts "OK: station has been created: #{station}"
  show_stations
end


def show_stations
  $stations.keys.each { |name| puts name }
end

def create_train
  puts 'CREATING THE TRAIN...'
  number = input('Enter number of train: ').to_i
  type = input('Enter type of train: ')

  train = $trainClassFromType[type].new(number)
  $trains[number] = train

  puts "OK: train has been created: #{train}"
  $trains.values.each do |train|
    new_label = train.number == number ? ' *--NEW--' : ''
    puts "train: number - #{train.number}, type - #{train.type}#{new_label}"
  end
end

def show_trains
  $trains.values.each do |train|
    puts "train: number - #{train.number}, type - #{train.type}"
  end
end

def show_trains_on_station
  get_station.trains.each { |train| train.number }
end

def create_route
  puts 'CREATING THE ROUTE...'
  name = input('Enter name of route: ')
  start_station = get_station('Enter name of start station: ')
  end_station = get_station('Enter name of end station: ')

  route = Route.new(start_station, end_station)
  $routes[name] = route

  puts "OK: route has been created: #{route}"
  show_routes
end

def show_routes
  $routes.keys.each { |name| puts name }
end

def show_route_stations
  get_route.stations.each { |station| puts station.name }
end

def add_station
  puts 'ADDING STATION TO ROUTE...'
  route = get_route
  station = get_station

  route.add_transitional_station(station)
end

def remove_station
  puts 'REMOVING STATION FROM ROUTE...'
  route = get_route
  station = get_station

  route.remove_transitional_station(station)
end

def set_route
  route = get_route
  train = get_train

  train.route = route
end

def attach_railcar
  train = get_train
  railcar = train.type == 'cargo' ? PassengerRailcar.new() : CargoRailcar.new
  train.attach_railcar(railcar)
end

def detach_railcar
  train = get_train
  railcar = train.type == 'cargo' ? PassengerRailcar.new() : CargoRailcar.new
  train.detach_railcar(railcar)
end

def move_bacward
  get_train.move_bacward
end

def move_forward
  get_train.move_forward
end

show_menu

loop do
  print 'Select the action, please (press 0 to show menu): '
  user_request = gets.chomp.to_i

  break if user_request == 9

  case user_request
  when 0
    show_menu
  when 1
    create_station
  when 2
    create_train
  when 3
    create_route
  when 10
    show_stations
  when 20
    show_trains
  when 21
    show_trains_on_station
  when 22
    set_route
  when 23
    attach_railcar
  when 24
    detach_railcar
  when 25
    move_bacward
  when 26
    move_forward
  when 30
    show_routes
  when 31
    show_route_stations
  when 32
    add_station
  when 33
    remove_station
  else
    puts "'#{user_request}' is wrong command. Choose action from menu"
  end

  puts
end
