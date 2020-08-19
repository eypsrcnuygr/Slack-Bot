# frozen_string_literal: true

require_relative '../lib/fetcher.rb'

describe FetchMethods do # rubocop:todo Metrics/BlockLength
  let(:stack_fetch) { FetchMethods::FetcherStackExchange.new('stackoverflow', 1) }
  let(:slack_post) { FetchMethods::PostSlack.new }
  describe '#condition_Checker' do
    it 'Checks the request is ok' do
      test = stack_fetch.condition_checker('asc', 'ruby', 'what')
      expect(test.code).to eql 200
    end
    it 'Checks the response is 400 when tag is not given' do
      test = stack_fetch.condition_checker('asc', '', '')
      expect(test.code).to eql 400
    end
  end

  describe '#questions' do
    it 'returns an array of links with calling #link_chooser' do
      stack_questions1 = stack_fetch.questions
      stack_questions2 = stack_questions1['items']
      filtered_questions = stack_fetch.link_chooser(stack_questions2)
      expect(filtered_questions).is_a? Array
    end
  end

  describe '#post' do
    it 'Checks the request is ok' do
      test = slack_post.post('Sercan')
      expect(test.code).to eql 200
    end

    it 'Checks the request is still ok when no input is given' do
      test = slack_post.post('')
      expect(test.code).to eql 200
    end
  end
end
