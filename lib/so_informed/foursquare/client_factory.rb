module SoInformed
  module Foursquare
    class ClientFactory
      def self.get_client(*args)
        case Rails.env.to_sym
          when :development
            LoggerClient.new(*args)
          when :test
            MockClient.new(*args)
          when :production
            ::Foursquare::Base.new(*args)
          else
            raise "No foursquare client for this environment"
        end
      end
    end
  end
end