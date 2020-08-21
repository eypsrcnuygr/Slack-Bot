require 'sinatra/base'
require 'net/http'
require 'dotenv'
require_relative './bot.rb'
require_relative './post_slack.rb'
require 'pry'

class API < Sinatra::Base
  attr_reader :stack_variable, :stack_links
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

      request_data['challenge']
    when 'event_callback'

      return if request_data['token'] != ENV['SLACK_TOKEN']

      event_data = request_data['event']
      case event_data['type']

      when 'message'
        Bot.handle_direct_message(event_data) if event_data['user']
      else
        puts "Unexpected events\n"
      end
      status 200
    end
  end

  post '/slack/attachments' do # rubocop:todo Metrics/BlockLength
    request.body.rewind
    request_data = request.body.read

    request_data = URI.decode_www_form_component(request_data, Encoding::UTF_8)

    request_data = JSON.parse(request_data.sub!('payload=', ''))
    url = request_data['response_url']
    user_id = request_data['user']['id']
    msg = request_data['original_message']

    case request_data['callback_id']

    when 'start:search'
      msg['text'] = 'Ok I am starting the search'
      msg['attachments'] = []
      API.send_response(url, msg)
      Bot.outro(user_id)

    when 'post:post'
      msg = Bot.show_answer(user_id)
      text = msg[:attachments][0][:actions][0][:text]
      Bot.post_slack(user_id, text)
      API.send_response(url, msg)

    when 'finish:search'
      msg['text'] = 'The search is finished'
      msg['attachments'] = []
      API.send_response(url, msg)
      client = Slack::Web::Client.new
      client.conversations_close(user: user_id)
    end
    status 200
  end
end
