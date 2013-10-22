module SoInformed
  module Foursquare
    class ClientFactory
      def self.get_client(*args)
        case Rails.application.config.foursquare_client
          when :logger
            LoggerClient.new(*args)
          when :mock
            MockClient.new(*args)
          when :real
            ::Foursquare::Base.new(*args)
          else
            raise "No foursquare client for this environment"
        end
      end
    end
  end
end