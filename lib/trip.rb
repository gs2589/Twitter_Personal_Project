class Trip
attr_accessor :start_address, :end_address, :raw_travel_time, :raw_travel_distance
  def initialize
  

  #("330 Elm Street, West Hempstead, NY", "501 w 183rd Street, New York, NY", 28.3, 2.666)

  puts "Please enter your starting address"
    @start_address= InputHandler.handle
    return if @start_address=="return"
  puts "Please enter your ending address"
    @end_address= InputHandler.handle
    return if @end_address == "return"
    
    #make csll to googlr api to get thee=se 
  
  
  
  
    #make a call to fetcher to help  get the following
    geo_hash=Fetcher.geo_fetcher(start_address, end_address)
    weather_hash=Fetcher.weather_fetcher(geo_hash[:mid_point])
    google_distance_matrix=Fetcher.google_distance_fetcher(geo_hash[:start_coordinates], geo_hash[:end_coordinates])
    @trip_bearing=geo_hash[:trip_bearing]
    @average_w_speed=weather_hash[:wind_speed]
    @average_w_bearing=weather_hash[:wind_bearing] #wind_bearing at start
    @raw_travel_time= google_distance_matrix[:time]
    @raw_travel_distance=google_distance_matrix[:distance]

    @headwind_speed=calculate_headwind_speed
    # puts "crosswind speed"
    @crosswind_speed=calculate_crosswind_speed
    # puts "wind adjusted travel time"
    @wind_adjusted_travel_time=calculate_adjusted_travel_time
    
    #calculated values
    puts "Your unadjusted travel time is #{raw_travel_time.round(2)} hours for a distance of #{raw_travel_distance} miles"
    puts "The wind speed will be #{@average_w_speed} mph coming from #{@average_w_bearing} compass degrees"
    puts "Your unadjusted assumed speed is #{(raw_travel_distance/raw_travel_time).round(2)} mph"
    puts ""
    puts "The direct headwind (+) / tailwind (-) component will be #{calculate_headwind_speed} mph"
    puts "Your adjusted assumed speed is #{(@raw_travel_distance/@raw_travel_time - (@headwind_speed * 0.37)).round(2)}"
    puts "Your wind adjusted travel time will be #{calculate_adjusted_travel_time} hours"
    puts "Enjoy your ride!!!!!"

   #binding.pry
  end

  def calculate_headwind_speed
    (@average_w_speed * Math.cos(radians(@trip_bearing-@average_w_bearing))*-1).round(2)
  end
  def calculate_crosswind_speed
    (@average_w_speed * Math.sin(radians(@trip_bearing-@average_w_bearing))*-1).round(2)
  end
  def calculate_adjusted_travel_time
    new_speed= @raw_travel_distance/@raw_travel_time - (@headwind_speed * 0.37)
    new_travel_time= (@raw_travel_distance/new_speed).round(2)
  end
  def radians(degrees)
    degrees * Math::PI / 180 
  end
end