# frozen-string-literal: true

require 'json'
require 'httparty'
require 'i18n'
require 'holidays_api_client/version'
require 'holidays_api_client/base'
require 'holidays_api_client/configuration'
require 'holidays_api_client/authenticator'
require 'holidays_api_client/fetcher'
require 'holidays_api_client/error'

module HolidaysApiClient
  I18n.available_locales = %i[ja en]

  def self.configure(&blk)
    Configuration.configure(&blk)
  end
end

HolidaysApiClient.configure do |config|
  config.api_url = 'http://holidays.revenue.metroengines.jp'
  config.auth_path = '/api/v1/auth'
  config.index_path = '/api/v1/holidays'
end
