# frozen_string_literal: true

require_relative './fetcher.rb'
require 'http'
require 'json'
require 'pry'

module Bot
  # This is a class
  class BotInteractivity
    def initialize(_acces_token = nil)
      @acces_token = ENV['SLACK_BOT_TOKEN']
      @array = ['first element', 'second element']
    end

    def botpost(input_text)
      rc = HTTP.post('https://f1a953029b83.ngrok.io/slack/commands', params: {
                       token: @acces_token,
                       channel: '#general',
                       text: input_text
                     })
                     binding.pry
      JSON.pretty_generate(JSON.parse(rc.body))
    end
  end
end
