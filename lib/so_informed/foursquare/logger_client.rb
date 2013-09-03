module SoInformed
  module Foursquare
    class LoggerClient
      def initialize(args); end

      def users; end

      def post(url, params)
        log ""
        log "foursquare [post] request to #{url}"
        log ""
      end

      def get(url, params)
        log ""
        log "foursquare [get] request to #{url}"
        log ""
      end

      private

      def log(message)
        Rails.logger.debug "FoursquareClient: #{message}"
      end
    end
  end
end