# frozen_string_literal: true

require_relative '../lib/fetcher.rb'

describe FetchMethods do
  let(:stack_fetch) { FetchMethods::FetcherStackExchange.new('stackoverflow', 1) }
  let(:slack_post) { FetchMethods::PostSlack.new}
  describe '#condition_Checker' do
    it 'Checks the request' do
      test = stack_fetch.condition_checker('asc', 'ruby', 'what')
      expect(test.code).to eql 200
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
end
