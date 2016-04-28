
require 'tweetstream'
require 'yaml'
require 'pry'
require 'colorize'



key = YAML.load_file("#{File.expand_path("applications.yml")}")


def connect
TweetStream.configure do |config|
  config.consumer_key       = key["consumer_key"]
  config.consumer_secret    = key["consumer_secret"]
  config.oauth_token        = key["access_token"]
  config.oauth_token_secret = key["access_token_secret"]
  config.auth_method        = :oauth
end

end
# This will pull a sample of all tweets based on
# your Twitter account's Streaming API role.
# TweetStream::Client.new.sample do |status|
#  puts "#{status.text}"

# end
  # The status object is a special Hash with
  # method access to its keys.

def no_visualization
  num=1
  TweetStream::Client.new.track('Hillary','Trump') do |status|
    puts num
    puts "#{status.text}"
    num+=1
  end
end

# included a level of abastraction
# include simple marker
def simple_vis_bw
  string_1='hillary'
  string_2='trump'
  marker_1=""
  marker_2=""
  score_1=0
  score_2=0
  TweetStream::Client.new.track(string_1,string_2) do |status|
    
    marker_1<<"-"  if status.text.downcase.include?(string_1)
    marker_2<<"-"  if status.text.downcase.include?(string_2)

    puts("#{string_1}: #{marker_1}")
    puts("#{string_2}: #{marker_2}")

    
  end
end




# add color
# pring on the same line

def print_race(string_1, string_2, marker_1, marker_2)
print("#{string_1}: #{marker_1}".blue, "\n", "#{string_2}: #{marker_2}".red,"\033[<1>A","\033[<#{string_1.length+2+marker_2.length}>D")
#print("\033[s","#{string_1}: #{marker_1}".blue, "\n", "#{string_2}: #{marker_2}".red,"\033[u")
end


def simple_vis_color
  string_1='hillary'
  string_2='trump'
  marker_1=""
  marker_2=""
  score_1=0
  score_2=0
  TweetStream::Client.new.track(string_1,string_2) do |status|
    
    marker_1<<"-"  if status.text.downcase.include?(string_1)
    marker_2<<"-"  if status.text.downcase.include?(string_2)

    print_race(string_1, string_2, marker_1, marker_2)
    
    
  end
end



#simple_vis_color


marker_1=""
marker_2=""
while true do
 print_race("Hillary", "Trump", marker_1, marker_2)
 marker_1<<"-"
 marker_2<<"--"
 sleep(0.5)
end