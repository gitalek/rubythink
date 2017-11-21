require_relative 'station'
require_relative 'train/cargo_train'
require_relative 'train/passenger_train'
require_relative 'route'
require_relative 'railcar/cargo_railcar'
require_relative 'railcar/passenger_railcar'

# class documentation
class Main
  attr_reader :stations, :trains, :routes, :train_class_from_type, :input_message

  def initialize
    @stations = {}
    @trains = {}
    @routes = {}

    @train_class_from_type = {
      'cargo' => CargoTrain,
      'passenger' => PassengerTrain
    }

    @create_railcar_from_type = {
      'cargo' => create_cargo_railcar,
      'passenger' => create_passenger_railcar
    }

    @input_message = <<-HEREDOC

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
  end

  def show_menu
    puts input_message
  end

  def input(request)
    print request
    gets.chomp
  end

  def get_station(request = 'Enter name of station: ')
    station = input(request)
    stations[station]
  end

  def get_train(request = 'Enter number of train: ')
    train_number = input(request)
    trains[train_number]
  end

  def get_railcar
    train = get_train
    show_railcars_of_train
  end

  def get_route(request = 'Enter name of route: ')
    route = input(request)
    routes[route]
  end

  def create_station
    puts 'CREATING THE STATION...'
    name = input('Enter name of station: ')

    station = Station.new(name)
    stations[name] = station

    puts "OK: station has been created: #{station}"
  end

  def show_stations
    puts '--- Created stations ---'
    stations.each_key { |name| puts name }
  end

  def create_train
    puts 'CREATING THE TRAIN...'
    type = input('Enter a type of the train: ')

    begin
      number = input('Enter a number of the train: ')
      train = train_class_from_type[type].new(number)
    rescue RuntimeError => e
      puts e.message
      retry
    end

    trains[number] = train

    puts "OK: train has been created: #{train}"
    trains.each_value do |train|
      new_label = train.number == number ? ' *--NEW--' : ''
      puts "train: number - #{train.number}, type - #{train.type}#{new_label}"
    end
  end

  def show_trains
    puts '--- Created trains ---'
    trains.each_value do |train|
      puts "train: number - #{train.number}, type - #{train.type}"
    end
  end

  # new (changed)
  def show_trains_on_station
    puts '--- Trains on station ---'
    block = proc do |train|
      puts "Number - #{train.number}, type - #{train.type}, amount of railcars: #{train.railcars.count}"
    end
    get_station.trains.each block
  end

  # new
  def create_passenger_railcar
    puts 'CREATING PASSENGER RAILCAR...'
    seats = input('Enter seating capacity of the railcar: ')

    PassengerRailcar.new(seats)
  end

  # new
  def create_cargo_railcar
    puts 'CREATING CARGO RAILCAR...'
    volume = input('Enter total volume of the railcar: ')

    CargoRailcar.new(volume)
  end

  # new
  def show_railcars_of_train
    puts 'CHOOSE TRAIN...'
    train = get_train

    passenger_block = proc do |railcar|
      puts "Type - #{railcar.type}, free seats - #{railcar.free_seats}, takken seats - #{railcar.takken_seats}"
    end

    cargo_block = proc do |railcar|
      puts "Type - #{railcar.type}, free volume - #{railcar.free_volume}, takken volume - #{railcar.takken_volume}"
    end

    block = train.type == 'Passenger' ? passenger_block : cargo_block
    train.each block
  end

  def create_route
    puts 'CREATING THE ROUTE...'
    name = input('Enter name of route: ')
    start_station = get_station('Enter name of start station: ')
    end_station = get_station('Enter name of end station: ')

    route = Route.new(start_station, end_station)
    routes[name] = route

    puts "OK: route has been created: #{route}"
  end

  def show_routes
    puts '--- Created routes ---'
    routes.each_key { |name| puts name }
  end

  def show_route_stations
    puts '--- Stations in route ---'
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
    puts 'SETTING ROUTE TO TRAIN...'
    route = get_route
    train = get_train

    train.route = route
  end

  def attach_railcar
    puts 'CHOOSE TRAIN...'
    train = get_train
    railcar = create_railcar_from_type[train.type]
    puts 'ATTACHING RAILCAR TO TRAIN...'
    train.attach_railcar(railcar)
    puts 'OK: THE RAILCAR WAS ATTACHED TO THE TRAIN'
  end

  def detach_railcar
    puts 'DETACHING RAILCAR FROM TRAIN...'
    train = get_train
    railcar = train.type == 'cargo' ? PassengerRailcar.new : CargoRailcar.new
    train.detach_railcar(railcar)
  end

  def move_bacward
    get_train.move_bacward
  end

  def move_forward
    get_train.move_forward
  end

  def run
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
  end
end
