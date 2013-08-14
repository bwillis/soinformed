module SoInformed
  module Sms
    class LoggerClient
      def process(message, numbers)
        numbers = Array.wrap(numbers) unless numbers.is_a?(Array)

        if numbers.empty?
          Rails.logger.debug "No numbers to send to."
        else
          numbers.each do |number|
            Rails.logger.debug "Sending SMS to 1#{number} :"
            Rails.logger.debug "    #{message}"
          end
        end
      end
    end
  end
end
