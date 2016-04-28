class InputHandler

def self.welcome_user
puts "Hello, Traveller! Welcome to the WindEx application"
puts "Type 'help'  for help"
puts "Type 'exit'  point to exit"
puts "Type 'bike' to calculate the adjusted time of arrival for your bike trip"
self.handle
end




def self.handle
 input=gets.chomp
  case input
  when "help"
    puts "we are helping you"
    puts "enter either an address or a name of a famous place"
    puts "sample address: 11 Broadway, new york, ny"
    puts "sample place: Empire State Building"
    self.welcome_user
  when "exit"
    puts "goodbye"
    "return"
  when "bike"
    Trip.new
  else
    input
    # "Your input is invalid- check yourself!"
    # self.welcome_user
  end
end

end