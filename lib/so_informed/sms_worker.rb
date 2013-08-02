module SoInformed
  class SmsWorker
    def process(message, numbers)
      numbers = Array.wrap(numbers) unless numbers.is_a?(Array)
      numbers.each do |number|
        begin
          client.account.sms.messages.create(
              :from => Settings.twilio_from_number,
              :to   => '+' + number,
              :body => message
          )
        rescue => e
          Rails.logger.warn(e)
        end
      end
    end

    private

    def client
      @client ||= Twilio::REST::Client.new(Settings.twilio_app_sid, Settings.twilio_secret)
    end
  end
end