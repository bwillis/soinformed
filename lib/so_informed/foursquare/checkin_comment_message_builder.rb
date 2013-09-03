module SoInformed
  module Foursquare
    class CheckinCommentMessageBuilder
      def initialize(name, message)
        @name = name; @message = message
      end

      def get_message
        "#{@name} commented: #{@message}"
      end

      def get_url
        "https://soinformed.heroku.com/"
      end
    end
  end
end