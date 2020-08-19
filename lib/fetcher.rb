# frozen_string_literal: true

require 'dotenv/load'
require 'http'
require 'httparty'
require 'json'
require 'pry'
require 'rubygems'
# This is a module
module FetchMethods
  # This is a class
  class FetcherStackExchange
    include HTTParty
    base_uri 'api.stackexchange.com'

    def initialize(service, _page)
      @options = { query: { site: service } }
    end

    def condition_checker(order, person_question, intitle)
      if intitle.nil?
        response = HTTParty.get("/2.2/search?page=1&order=#{order}&sort=votes&tagged=#{person_question}",
                                @options)
        response
      else
        response2 = self.class.get("/2.2/search?page=1&order=#{order}&sort=votes
          &tagged=#{person_question}&intitle=#{intitle}",
                                   @options)
        response2
      end
    end

    def questions
      puts "What is the tag you want to search:\n"
      person_question = gets.chomp
      puts "Do you want ascending order, or descending order\n Please write 'asc' or 'desc'\n"
      order = gets.chomp
      raise('Invalid order') unless order.include?('asc') || order.include?('desc')

      puts "What you want to have in your title\n"
      intitle = gets.chomp
      response = condition_checker(order, person_question, intitle)
      response
    end

    def link_chooser(object)
      array = []
      object.each_with_index do |_item, index|
        array.push(object[index]['link'])
      end
      array
    end
  end
  # This is a class
  class PostSlack
    def initialize(_acces_token = nil)
      @acces_token = ENV['SLACK_API_TOKEN']
    end

    def post(input_text)
      rc = HTTP.post('https://slack.com/api/chat.postMessage', params: {
                       token: @acces_token,
                       channel: '#general',
                       text: input_text,
                       as_user: true
                     })
      rc
      # JSON.pretty_generate(JSON.parse(rc.body))
    end
  end
end
