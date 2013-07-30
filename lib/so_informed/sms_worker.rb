module SoInformed
  class SmsWorker
    def start(message, numbers)
      numbers.each do |number|
        begin
          client.account.sms.messages.create(
              :from => '+14158133341',
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