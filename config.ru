# frozen_string_literal: true

require './bin/main2'

# Initialize the app and create the API (bot) object
run Rack::Cascade.new [API]
