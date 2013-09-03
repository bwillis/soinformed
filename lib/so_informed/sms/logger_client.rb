module SoInformed
  module Sms
    class LoggerClient
      def process(message, numbers)
        numbers = Array.wrap(numbers) unless numbers.is_a?(Array)

        log ""
        if numbers.empty?
          log "No numbers to send to."
        else
          numbers.each do |number|
            log "Sending SMS to 1#{number} :"
            log "    #{message}"
          end
        end
        log ""
      end

      private

      def log(message)
        Rails.logger.debug "SmsClient: #{message}"
      end
    end
  end
end
