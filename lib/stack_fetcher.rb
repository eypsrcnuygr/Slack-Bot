require 'dotenv/load'
require 'http'
require 'httparty'
require 'json'
require 'pry'
require 'rubygems'

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
end
