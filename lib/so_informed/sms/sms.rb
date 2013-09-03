module SoInformed
  module Sms
    class Sms

      attr_reader :from, :body

      def initialize(from, body)
        @from = from; @body = body
      end
    end
  end
end
