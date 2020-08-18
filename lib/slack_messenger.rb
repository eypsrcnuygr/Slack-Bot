# frozen_string_literal: true

require 'httpclient'

# this is a class
class SlackMessenger
  SLACK_API_ENDPOINT = 'https://slack.com/api/chat.postMessage'

  def initialize
    @first_question = "What is the tag you want to search:\n"
    @second_question = "Do you want ascending order, or descending order\n Please write 'asc' or 'desc'\n"
    @third_question = "What you want to have in your title\n"
  end

  def deliver
    client = HTTPClient.new
    client.post(SLACK_API_ENDPOINT, params)
  end

  def params
    {
      token: ENV['SLACK_API_TOKEN'],
      channel: '#general',
      text: "#{@first_question} #{@second_question} #{@third_question}",
      link_names: true
    }
  end
end
