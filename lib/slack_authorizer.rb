# frozen_string_literal: true

# THis is a class
class SlackAuthorizer
  UNAUTHORIZED_MESSAGE = 'Ops! Looks like the application is not authorized! Please review the token configuration.'
  UNAUTHORIZED_RESPONSE = ['200', { 'Content-Type' => 'text' }, [UNAUTHORIZED_MESSAGE]].freeze
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.params['token'] == ENV['SLACK_TOKEN']
      @app.call(env)
    else
      UNAUTHORIZED_RESPONSE
    end
  end
end
