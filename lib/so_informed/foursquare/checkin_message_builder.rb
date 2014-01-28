require './lib/so_informed/message_builder'

module SoInformed
  module Foursquare
    class CheckinMessageBuilder

      SMS_MAX_LENGTH = 160
      REPLY_TEXT = 'Reply to comment'

      def self.from_checkin(username, checkin, venue, location_display=:text)
        builder = SoInformed::MessageBuilder.new
        builder.add_spaces = true
        builder.add username
        builder.add 'is at'
        builder.add checkin.venue_name
        if checkin.has_address?
          builder.add "(#{location_display == :text ? checkin.address : venue.short_url})"
        end
        builder.add checkin.shout if checkin.has_shout?
        builder.add_optional REPLY_TEXT
        builder.message SMS_MAX_LENGTH
      end

    end
  end
end
