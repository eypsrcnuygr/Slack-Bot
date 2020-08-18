# frozen_string_literal: true

require 'sinatra/base'
require 'net/http'
require_relative './slack_authorizer.rb'
require_relative './slack_messenger.rb'

# This is a class
class API < Sinatra::Base
  # Send response of message to response_url
  # def self.send_response(response_url, msg)
  #   url = URI.parse(response_url)
  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true
  #   request = Net::HTTP::Post.new(url)
  #   request['content-type'] = 'application/json'
  #   request.body = JSON[msg]
  #   http.request(request)
  # end

  # post '/slack/events' do
  #   request_data = JSON.parse(request.body.read)
  #   case request_data['type']
  #   when 'url_verification'
  #     # URL Verification event with challenge parameter
  #     request_data['challenge']
  #   when 'event_callback'
  #     # Verify requests
  #     return if request_data['token'] != ENV['SLACK_VERIFICATION_TOKEN']

  #     event_data = request_data['event']
  #     case event_data['type']
  #       # Message IM event
  #     when 'message'
  #       return if event_data['subtype'] == 'bot_message' || event_data['subtype'] == 'message_changed'

  #       Bot.handle_direct_message(event_data) if event_data['user']
  #     else
  #       puts "Unexpected events\n"
  #     end
  #     status 200
  #   end
  # end

  use SlackAuthorizer

  VALID_CONGRATULATE_EXPRESSION = /^(@[\w\.\-_]+) (.+)/.freeze

  HELP_RESPONSE = 'Use `/surf` to see the options`'
  OK_RESPONSE = "Thanks for sending this! I'll share it with %s."
  INVALID_RESPONSE = 'Sorry, I didn’t quite get that. You need to write down the tag you want to search for it.'
  post '/slack/command' do
    case params['text'].to_s.strip
    when 'help', '' then HELP_RESPONSE
    when VALID_CONGRATULATE_EXPRESSION
      from = Regexp.last_match(1)
      message = Regexp.last_match(2)
      SlackMessenger.deliver(params['user_name'], from, message)
      OK_RESPONSE % from
    else INVALID_RESPONSE
    end
  end
end
