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

  include FetchMethods
  attr_accessor :slack_msg, :stack, :message
  def initialize
    @stack = FetcherStackExchange.new('stackoverflow', 1)
    @slack_msg = SlackMessenger.new
    @message = ''
  end

  VALID_CONGRATULATE_EXPRESSION = /^(@[\w\.\-_]+) (.+)/.freeze

  HELP_RESPONSE = 'Use `/surf` to see the options`'
  INVALID_RESPONSE = 'Sorry, I didn’t quite get that. You need to write down the tag you want to search for it.'
  FIRST_QUESTION = "What is the tag you want to search:\n"
  SECOND_QUESTION = "Do you want ascending order, or descending order\n Please write 'asc' or 'desc'\n"
  THIRD_QUESTION = "What you want to have in your title\n"
  post '/slack/command' do
    case params['text'].to_s.strip
    when 'help', '' then HELP_RESPONSE
    when FIRST_QUESTION
      slack_msg.deliver
      message = Regexp.last_match(1)
      message
    when SECOND_QUESTION
      slack_msg.deliver
      message = Regexp.last_match(1)
      message
    when THIRD_QUESTION
      slack_msg.deliver
      message = Regexp.last_match(1)
      message
    else INVALID_RESPONSE
    end
  end
end
