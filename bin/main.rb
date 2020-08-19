# frozen_string_literal: true

require_relative '../lib/fetcher.rb'

# This is a module
module MainModule
  # THis is a class
  class Main
    include FetchMethods
    attr_reader :slack, :stack, :questions_first, :questions_second
    def initialize
      @stack = FetcherStackExchange.new('stackoverflow', 1)
      @slack = PostSlack.new
    end

    def engine
      @questions_first = stack.questions
      @questions_second = @questions_first['items']
      @last_version = stack.link_chooser(@questions_second)
      @real_last_version = @last_version[0..9]
      @slack_post = slack.post(@real_last_version.to_s)
    end
  end

  new_main = Main.new
  new_main.engine
end
