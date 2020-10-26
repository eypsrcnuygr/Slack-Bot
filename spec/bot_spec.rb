require_relative '../lib/stack_fetcher.rb'
require_relative '../lib/post_slack.rb'

describe FetcherStackExchange do
  let(:stack_fetch) { FetcherStackExchange.new('stackoverflow', 1) }
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
end

describe PostSlack do
  let(:slack_post) { PostSlack.new }
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
