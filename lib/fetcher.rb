# frozen_string_literal: true

require 'dotenv/load'
require 'hashie'
require 'http'
require 'httparty'
require 'json'
require 'pry'
require 'rubygems'
require_relative './slack_messenger.rb'
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
        self.class.get("/2.2/search?page=1&order=#{order}&sort=votes&tagged=#{person_question}",
                       @options)
      else
        self.class.get("/2.2/search?page=1&order=#{order}&sort=votes&tagged=#{person_question}&intitle=#{intitle}",
                       @options)
      end
    end

    def questions
      puts "What is the tag you want to search:\n"
      person_question = gets.chomp
      puts "Do you want ascending order, or descending order\n Please write 'asc' or 'desc'\n"
      order = gets.chomp
      puts "What you want to have in your title\n"
      intitle = gets.chomp
      condition_checker(order, person_question, intitle)
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
      @array = ['first element', 'second element']
    end

    def post(input_text)
      rc = HTTP.post('https://slack.com/api/chat.postMessage', params: {
                       token: @acces_token,
                       channel: '#general',
                       text: input_text,
                       as_user: true
                     })
      JSON.pretty_generate(JSON.parse(rc.body))
    end

    def questions(input_text)
      uri = URI('https://slack.com/api/chat.postMessage')
      res = Net::HTTP.post_form(uri, 'token' => @acces_token, 'channel' => '#general', 'text' => input_text)
      res2 = JSON.pretty_generate(JSON.parse(res.body))
      puts res2
    end
  end
end
