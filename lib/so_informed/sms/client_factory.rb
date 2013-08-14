module SoInformed
  module Sms
    class ClientFactory
      def self.get_client
        if Rails.env.development?
          LoggerClient.new
        else
          TwilioClient.new
        end
      end
    end
  end
end
