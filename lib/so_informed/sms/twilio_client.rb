module SoInformed
  module Sms
    class TwilioClient
      def process(message, numbers)
        numbers = Array.wrap(numbers) unless numbers.is_a?(Array)
        numbers.each do |number|
          begin
            client.account.sms.messages.create(
                :from => Rails.application.secrets.twilio_from_number,
                :to   => '+1' + number,
                :body => message
            )
          rescue => e
            Rails.logger.warn(e)
          end
        end
      end

      private

      def client
        @client ||= Twilio::REST::Client.new(
            Rails.application.secrets.twilio_app_sid,
            Rails.application.secrets.twilio_secret
        )
      end
    end
  end
end
