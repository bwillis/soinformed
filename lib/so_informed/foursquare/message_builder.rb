module SoInformed
  module Foursquare
    class MessageBuilder
      attr_writer :address, :comment

      def initialize(name, location)
        @name = name; @location = location
      end

      def get_message
        message = "#{@name} checked-in at #{@location}"
        message << " (#{@address})" if @address
        message << " #{@comment}" if @comment
        message
      end

      def self.from_checkin(checkin, location_display=:text)
        message = Foursquare::MessageBuilder.new(checkin.username, checkin.venue_name)
        message.comment = checkin.shout if checkin.has_shout?
        if checkin.has_address?
          case location_display
            when :text
              message.address = checkin.address
            when :link
              message.address = "http://google.com"
          end
        end
        message
      end
    end
  end
end
