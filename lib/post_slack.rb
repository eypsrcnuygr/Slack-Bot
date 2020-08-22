require 'dotenv/load'
require 'http'

class PostSlack
  def initialize(_acces_token = nil)
    @acces_token = ENV['SLACK_API_TOKEN']
  end

  def post(input_text)
    rc = HTTP.post('https://slack.com/api/chat.postMessage', params: {
                     token: @acces_token,
                     channel: '#stack-responses',
                     text: input_text,
                     as_user: true
                   })
    rc
  end
end
