# frozen_string_literal: true

require_relative '../lib/fetcher.rb'

# This is a module
module MainModule
  # THis is a class
  class Main
    include FetchMethods
    attr_accessor :slack, :stack
    def initialize
      @stack = FetcherStackExchange.new('stackoverflow', 1)
      @slack = PostSlack.new('slack')
      @array = ["What do you want to search for?\n",
                "Do you want ascending order, or descending order\n Please write 'asc' or 'desc'\n",
                "What you want to have in your title\n"]
    end

    def engine
      @test1 = stack.questions
      @test2 = @test1['items']
      @last_version = stack.link_chooser(@test2)
      @real_last_version = @last_version[0..9]
      @test3 = slack.post(@real_last_version.to_s)
      [@real_last_version, @test3]
    end

    def engine2
      slack.questions(@array[0])
    end
  end

  new_main = Main.new
  puts new_main.engine2
end
