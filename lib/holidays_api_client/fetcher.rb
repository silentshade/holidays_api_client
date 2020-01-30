# frozen_string_literal: true

module HolidaysApiClient
  class Fetcher
    include HolidaysApiClient::Base

    private

    def initialize(**args)
      @params = args[:params]
      @token = args[:token]
    end

    attr_reader :params, :token

    def call
      JSON.parse(response.body).each_with_object({}) do |holiday_data, hsh|
        holiday_data['dates'].map do |date|
          hsh[date] = holiday_data.slice('ja_name', 'en_name').fetch(I18n.locale.to_s + '_name')
        end
      end
    rescue StandardError => e
      raise HolidaysApiClient::Error, e.message
    end

    def response
      @_response = HTTParty.get(Configuration.holidays_url, query: params, headers: { Authorization: token })
    end
  end
end
