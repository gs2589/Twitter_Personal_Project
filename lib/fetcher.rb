

class Fetcher

#http://www.rubydoc.info/github/alexreisner/geocoder/Geocoder/Calculations#bearing_between-instance_method
#--------------------------
# location_1 = Geocoder.search("address/name")
# location_2 = Geocoder.search("address/name")
# bearing = Geocoder::Calculations.bearing_between(location_1[0].coordinates, location_2[0].coordinates)
# distance = Geocoder::Calculations.distance_between(location_1[0].coordinates, location_2[0].coordinates)

def self.geo_fetcher(starting_address, ending_address)
  geo_hash = {}
  location_1 = Geocoder.search(starting_address)[0]
  location_2 = Geocoder.search(ending_address)[0]
  geo_hash[:trip_bearing] = Geocoder::Calculations.bearing_between(location_1.coordinates, location_2.coordinates)-180
  geo_hash[:trip_distance] = Geocoder::Calculations.distance_between(location_1.coordinates, location_2.coordinates)
  geo_hash[:start_address] = location_1.address
  geo_hash[:end_address] = location_2.address
  geo_hash[:start_coordinates] = location_1.coordinates
  geo_hash[:end_coordinates] = location_2.coordinates
  geo_hash[:mid_point]=Geocoder::Calculations.geographic_center([location_1.coordinates, location_2.coordinates])
  geo_hash
  #binding.pry
end


def self.weather_fetcher(mid_point_coordinates)
  weather_hash={}
  key = YAML.load_file("./applications.yml")["weather_key"]
  api_data = RestClient.get("http://api.openweathermap.org/data/2.5/weather?lat=#{mid_point_coordinates.first}&lon=#{mid_point_coordinates.last}&units=imperial&appid=#{key}")
  api_data_hash = JSON.parse(api_data)
  weather_hash[:wind_bearing] = api_data_hash["wind"]["deg"]
  weather_hash[:wind_speed] = api_data_hash["wind"]["speed"]
  weather_hash
end

def self.google_distance_fetcher(start_coordinates, end_coordinates)
  google_distance_hash = {}
  key = YAML.load_file("./applications.yml")["gmaps_key"]
  api_data = RestClient.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{start_coordinates.join(",")}&destinations=#{end_coordinates.join(",")}&mode=bicycling&key=#{key}")
  api_data_hash = JSON.parse(api_data)
  google_distance_hash[:distance] = api_data_hash["rows"].first["elements"].first["distance"]["text"][0..-4].to_f
  time_array = api_data_hash["rows"].first["elements"].first["duration"]["text"].split(/\b hours*\s\b|\b mins*\b/)
  google_distance_hash[:time] = time_array.last.to_f/60 
  (google_distance_hash[:time]= google_distance_hash[:time] + time_array.first.to_f) if time_array.size == 2
  google_distance_hash
end

end






