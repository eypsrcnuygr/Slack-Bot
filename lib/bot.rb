# frozen_string_literal: true

require 'slack-ruby-client'
require_relative './stack_fetcher.rb'
require_relative './post_slack.rb'
require 'pry'

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

  def self.after_search # rubocop:todo Metrics/MethodLength
    [{
      color: '#5DFF00',
      title: 'Do you want to try it',
      callback_id: 'post:post',
      actions: [
        {
          name: 'done',
          text: 'Try',
          type: 'button',
          value: 'finish:search'
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

  def self.link_arranger(object)
    array = []
    object.each_with_index do |_item, index|
      array.push(object[index][:text])
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

  def self.show_answer(user_id)
    {
      text: 'Please accept my offer',
      attachments: link_creator(user_id)
    }
  end

  def self.link_creator(_user_id)
    stack_variable = fetch_stack('asc', 'ruby', 'none')
    stack_links = link_chooser(stack_variable['items'])
    attachment = []
    attachment << {
      color: '#FFA500',
      callback_id: 'finish:search',
      title: 'Goodbye!',
      actions: [
        {
          name: 'post',
          text: stack_links,
          type: 'plain_text',
          value: 'post:post'
        }
      ]
    }
    attachment
  end

  def self.outro(user_id)
    # Open IM
    client = Slack::Web::Client.new
    res = client.conversations_open(users: user_id)
    # Attachment with post:post callback ID
    attachments = after_search
    return if res.channel.id.nil?

    # Send message
    client.chat_postMessage(
      channel: res.channel.id,
      text: 'The results will be displayed',
      attachments: attachments.to_json
    )
  end

  def self.fetch_stack(order, person_question, intitle)
    # Starts new game
    stack = FetcherStackExchange.new('stackoverflow', 1)
    stack.condition_checker(order, person_question, intitle)
  end

  def self.post_slack(_user_id, input_text)
    post = PostSlack.new
    post.post(input_text)
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
      @plays[user_id] = 'User'
    else
      client = Slack::Web::Client.new
      client.chat_postMessage(
        channel: msg['channel'],
        text: 'Let\'s keep asking'
      )
      @plays[user_id] = nil
    end
  end
end
