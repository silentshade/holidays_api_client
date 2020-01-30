# frozen_string_literal: true

module HolidaysApiClient
  class Authenticator
    include HolidaysApiClient::Base

    private

    def call
      raise(HolidaysApiClient::Error, response.msg) unless response.ok?

      token = (JSON.parse(response.body) rescue {})['token']
      raise(HolidaysApiClient::Error, 'Token not valid') unless token

      token
    end

    def response
      @_response ||= HTTParty.post(
        Configuration.authenticate_url, body: { email: Configuration.email, password: Configuration.password }
      )
    end
  end
end
