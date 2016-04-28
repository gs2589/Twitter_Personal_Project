require 'bundler/setup'
Bundler.require(:default, :development, :test)
$: << '.'

# Dir["app/concerns/*.rb"].each {|f| require f}
# Dir["app/models/*.rb"].each {|f| require f}
# Dir["app/data_fetchers/*.rb"].each {|f| require f}
# Dir["app/runners/*.rb"].each {|f| require f}

Dir["lib/*.rb"].each {|f| require f}

require "open-uri"
require "json"
require 'pry'
