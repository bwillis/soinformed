module SoInformed
  module Sms
    class ClientFactory
      def self.get_client
        if [:development, :test].include? Rails.env.to_sym
          LoggerClient.new
        else
          TwilioClient.new
        end
      end
    end
  end
end
