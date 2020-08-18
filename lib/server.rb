# frozen_string_literal: true

require 'sinatra/base'
require 'net/http'
require_relative './slack_authorizer.rb'
require_relative './slack_messenger.rb'
require_relative './fetcher.rb'
require 'pry'
# This is a class
class API < Sinatra::Base
  use SlackAuthorizer

  VALID_CONGRATULATE_EXPRESSION = /^(@[\w\.\-_]+) (.+)/.freeze
  HELP_RESPONSE = 'Use `/congratulate` to send a congratulation message to someone. Example: `/congratulate @anderson for design the new API`'
  OK_RESPONSE = "Thanks for sending this! I'll share it with %s."
  INVALID_RESPONSE = 'Sorry, I didn’t quite get that. Perhaps try the words in a different order? This usually works: `/congratulate [@someone] [message]`.'
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
