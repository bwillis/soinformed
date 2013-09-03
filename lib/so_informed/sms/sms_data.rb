module SoInformed
  module Sms
    class SmsData

      def self.default(from="5555555555", body="This is a soinformed test!")
        from = "+1#{from}"
        SoInformed::Sms::Sms.new(from, body)
      end
    end
  end
end
