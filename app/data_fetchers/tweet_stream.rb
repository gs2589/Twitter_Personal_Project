
require 'tweetstream'
require 'yaml'
require 'pry'



key = YAML.load_file("#{File.expand_path("applications.yml")}")



TweetStream.configure do |config|
  config.consumer_key       = key["consumer_key"]
  config.consumer_secret    = key["consumer_secret"]
  config.oauth_token        = key["access_token"]
  config.oauth_token_secret = key["access_token_secret"]
  config.auth_method        = :oauth
end

# This will pull a sample of all tweets based on
# your Twitter account's Streaming API role.
# TweetStream::Client.new.sample do |status|
#  puts "#{status.text}"

# end
  # The status object is a special Hash with
  # method access to its keys.
num=1
TweetStream::Client.new.track('Israel','Syria') do |status|
  puts num
  puts "#{status.text}"
  num+=1
end

