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
      'cargo' => method(:create_cargo_railcar),
      'passenger' => method(:create_passenger_railcar)
    }

    @fill_the_railcar_from_type = {
      'cargorailcar' => method(:fill_cargo_railcar),
      'passengerrailcar' => method(:fill_passenger_railcar)
    }

    @process_railcar_block = {
      'cargo' => proc do |railcar|
        puts "No. #{railcar.number}, type - #{railcar.type}, free volume - #{railcar.free_volume}, takken volume - #{railcar.takken_volume}"
      end,
      'passenger' => proc do |railcar|
        puts "No. #{railcar.number}, type - #{railcar.type}, free seats - #{railcar.free_seats}, takken seats - #{railcar.takken_seats}"
      end
    }

    @show_trains_on_station_block = proc do |train|
      puts "No. #{train.number}, type - #{train.type}, amount of railcars: #{train.railcars.count}"
    end

    @input_message = <<-HEREDOC

    Menu:

    0 - show this menu
    -------------------------------------------------------
    1 - create station  10 - show list of created stations
                        11 - show trains on station
                        12 - show stations and trains
    -------------------------------------------------------
    2 - create train    20 - show list of created trains
                        21 - show list of trains on station
                        22 - set route to train
                        23 - attach railcar to train
                        24 - detach railcar from train
                        25 - show railcars of train
                        26 - fill the railcar
                        27 - move train backward
                        28 - move train forward
    -------------------------------------------------------
    3 - create route    30 - show list of created routes
                        31 - show list of stations in route
                        32 - add station to route
                        33 - remove station from route
    -------------------------------------------------------
    9  - exit

    HEREDOC
  end

  def show_menu
    puts input_message
  end

  def random_input(request)
    print request
    gets.chomp
  end

  def float_input(request)
    format = /^[1-9]\d*(\.\d*)?$/

    begin
      print request
      response = gets.chomp
      raise 'Input number, please' unless format =~ response
    rescue RuntimeError => e
      puts e.message
      retry
    end

    response.to_f
  end

  def integer_input(request)
    format = /^[1-9]\d*$/

    begin
      print request
      response = gets.chomp
      raise 'Input integer, please' unless format =~ response
    rescue RuntimeError => e
      puts e.message
      retry
    end

    response.to_i
  end

  def get_station(request = 'Enter name of station: ')
    station = random_input(request)
    stations[station]
  end

  def get_train(request = "CHOOSE TRAIN...\nEnter number of train: ")
    train_number = random_input(request)
    trains[train_number]
  end

  def get_route(request = 'Enter name of route: ')
    route = random_input(request)
    routes[route]
  end

  def get_railcar(train)
    puts 'CHOOSE RAILCAR NUMBER'
    show_railcars_of_train(train)
    railcar_number = integer_input('Enter number of chosen railcar: ')

    train.get_railcar_by_number(railcar_number.to_i)
  end

  def create_station
    puts 'CREATING THE STATION...'
    name = random_input('Enter name of station: ')

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
    type = random_input('Enter type of the train: ')

    begin
      number = random_input('Enter number of the train: ')
      train = train_class_from_type[type].new(number)
    rescue RuntimeError => e
      puts e.message
      retry
    end

    trains[number] = train

    puts "OK: train has been created: #{train}"
    trains.each_value do |train|
      new_label = train.number == number ? ' *--NEW--' : ''
      puts "train: No. #{train.number}, type - #{train.type}#{new_label}"
    end
  end

  def show_trains
    puts '--- Created trains ---'
    trains.each_value do |train|
      puts "train: No. #{train.number}, type - #{train.type}"
    end
  end

  def show_trains_on_station
    puts '--- Trains on station ---'
    get_station.trains.each(&show_trains_on_station_block)
  end

  def show_trains_on_stations
    station.all do |station|
      puts "Station #{station.name}"
      station.trains.each(&show_trains_on_station_block)
      puts '-------------------------------'
    end
  end

  def create_passenger_railcar
    puts 'CREATING PASSENGER RAILCAR...'
    seats = integer_input('Enter seating capacity of the railcar: ')
    PassengerRailcar.new(seats.to_i)
  end

  def create_cargo_railcar
    puts 'CREATING CARGO RAILCAR...'
    volume = float_input('Enter total volume of the railcar: ')
    CargoRailcar.new(volume.to_f)
  end

  def show_railcars_of_train(train)
    block = @process_railcar_block[train.type]
    train.each_railcar(block)
  end

  def show_railcars
    train = get_train
    show_railcars_of_train(train)
  end

  def create_route
    puts 'CREATING THE ROUTE...'
    name = random_input('Enter name of route: ')
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
    train = get_train
    railcar = @create_railcar_from_type[train.type].call
    puts 'ATTACHING RAILCAR TO TRAIN...'
    train.attach_railcar(railcar)
    puts 'OK: THE RAILCAR WAS ATTACHED TO THE TRAIN'
  end

  def detach_railcar
    train = get_train
    railcar = get_railcar(train)
    puts 'DETACHING RAILCAR FROM TRAIN...'
    train.detach_railcar(railcar)
  end

  def fill_cargo_railcar(railcar)
    volume = float_input('Enter volume: ')
    railcar.take_a_volume(volume)
  end

  def fill_passenger_railcar(railcar)
    railcar.take_a_seat
  end

  def fill_the_railcar
    train = get_train
    railcar = get_railcar(train)
    @fill_the_railcar_from_type[railcar.class.to_s.downcase].call(railcar)
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
      when 11
        show_trains_on_station
      when 12
        show_trains_on_stations
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
        show_railcars
      when 26
        fill_the_railcar
      when 27
        move_bacward
      when 28
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
