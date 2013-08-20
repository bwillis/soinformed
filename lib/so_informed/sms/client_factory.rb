module SoInformed
  module Sms
    class ClientFactory
      def self.get_client
        if [:development, :test].include? Rails.env
          LoggerClient.new
        else
          TwilioClient.new
        end
      end
    end
  end
end
