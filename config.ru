# frozen_string_literal: true

require './lib/server.rb'

# Initialize the app and create the API (bot) object
run Rack::Cascade.new [API]
