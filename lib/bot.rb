require 'slack-ruby-client'
require_relative './stack_fetcher.rb'

class Bot # rubocop:todo Metrics/ClassLength
  def self.new_game(question) # rubocop:todo Metrics/MethodLength
    [{
      color: '#5DFF00',
      title: question,
      callback_id: 'start:search',
      actions: [
        {
          name: 'start',
          text: '   YES   ',
          type: 'button',
          value: 'start:search'
        }
      ]
    }, {
      color: '#FF0000',
      title: '',
      callback_id: 'finish:search',
      actions: [
        {
          name: 'start',
          text: '   NO   ',
          type: 'button',
          value: 'finish:search'
        }
      ]
    }]
  end

  def self.after_search(question) # rubocop:todo Metrics/MethodLength
    [{
      color: '#5DFF00',
      title: '',
      callback_id: 'post:post',
      actions: [
        {
          name: 'done',
          text: question,
          type: 'plain_text',
          value: 'post:post'
        }
      ]
    }]
  end

  def self.link_chooser(object)
    array = []
    object.each_with_index do |_item, index|
      array.push(object[index]['link'])
    end
    array
  end

  def self.intro(user_id)
    # Open IM
    client = Slack::Web::Client.new
    res = client.conversations_open(users: user_id)
    # Attachment with play:start callback ID
    attachments = new_game('Do you want to search a post')
    return if res.channel.id.nil?

    # Send message
    client.chat_postMessage(
      channel: res.channel.id,
      text: 'Hi I am a StackOverFlow searcher',
      attachments: attachments.to_json
    )
  end

  def self.outro(user_id)
    # Open IM
    client = Slack::Web::Client.new
    res = client.conversations_open(users: user_id)
    # Attachment with play:start callback ID
    attachments = after_search('The search is done')
    return if res.channel.id.nil?

    # Send message
    client.chat_postMessage(
      channel: res.channel.id,
      text: 'Hi I am a StackOverFlow searcher second',
      attachments: attachments.to_json
    )
  end

  def self.fetch_stack(order, person_question, intitle)
    # Starts new game
    stack = FetcherStackExchange.new('stackoverflow', 1)
    stack.condition_checker(order, person_question, intitle)
  end

  def self.plays(user_id)
    @plays ||= { user_id => nil }
  end

  # Check if user has order to handle dm
  def self.handle_direct_message(msg)
    user_id = msg['user']
    plays(user_id)
    if @plays[user_id].nil?
      intro(user_id)

    else
      client = Slack::Web::Client.new
      client.chat_postMessage(
        channel: msg['channel'],
        text: 'Let\'s keep playing the last game'
      )
    end
  end
end
