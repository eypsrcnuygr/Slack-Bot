# frozen_string_literal: true

require 'sinatra/base'
require 'net/http'
# This is a class
class API < Sinatra::Base
  # Send response of message to response_url
  def self.send_response(response_url, msg)
    url = URI.parse(response_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/json'
    request.body = JSON[msg]
    http.request(request)
  end

  post '/slack/events' do
    request_data = JSON.parse(request.body.read)
    case request_data['type']
    when 'url_verification'
      # URL Verification event with challenge parameter
      request_data['challenge']
    when 'event_callback'
      # Verify requests
      return if request_data['token'] != ENV['SLACK_VERIFICATION_TOKEN']

      event_data = request_data['event']
      case event_data['type']
        # Message IM event
      when 'message'
        return if event_data['subtype'] == 'bot_message' || event_data['subtype'] == 'message_changed'

        Bot.handle_direct_message(event_data) if event_data['user']
      else
        puts "Unexpected events\n"
      end
      status 200
    end
  end

  post '/slack/command' do
    'OK'
  end
end
