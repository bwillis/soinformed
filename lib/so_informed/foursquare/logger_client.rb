module SoInformed
  module Foursquare
    class LoggerClient
      def initialize(args); end

      def users; end

      def post(url, params)
        Rails.logger.debug "foursquare [post] request to #{url}"
      end

      def get(url, params)
        Rails.logger.debug "foursquare [get] request to #{url}"
      end
    end
  end
end