# frozen-string-literal: true
require 'singleton'
require 'forwardable'

module HolidaysApiClient
  class Configuration
    include Singleton

    DEFAULT_SCHEME = 'http'

    attr_accessor :api_url, :email, :password, :auth_path, :index_path, :scheme

    class << self
      def configure
        instance.clear_cache
        yield instance
      end

      def method_missing(meth, *args)
        instance.respond_to?(meth) ? instance.send(meth) : super
      end

      def respond_to_missing?(meth, include_private = false)
        instance.respond_to?(meth, include_private) || super
      end
    end

    def authenticate_url
      @_authenticate_url ||= begin
        api_uri = URI.parse(api_url)
        api_uri.scheme = scheme || DEFAULT_SCHEME
        api_uri.path = auth_path
        api_uri.to_s
      end
    end

    def holidays_url
      @_holidays_url ||= begin
        api_uri = URI.parse(api_url)
        api_uri.scheme = scheme || DEFAULT_SCHEME
        api_uri.path = index_path
        api_uri.to_s
      end
    end

    def clear_cache
      instance_variables.select { |v| v.to_s.start_with?('@_') }.map { |v| instance_variable_set v, nil }
    end
  end
end
