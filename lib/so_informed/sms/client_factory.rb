module SoInformed
  module Sms
    class ClientFactory
      def self.get_client
        case Rails.env.to_sym
          when :development
            LoggerClient.new
          when :test
            MockClient.new
          when :production
            TwilioClient.new
          else
            raise "No sms client for this environment"
        end
      end
    end
  end
end
