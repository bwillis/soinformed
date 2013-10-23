require 'active_support/core_ext/array/conversions'

module SoInformed
  class CheckinInformer

    attr_reader :user, :notifiable_contacts

    def initialize(checkin)
      @checkin = checkin
      if @user = User.find_by_uid(@checkin.user_id)
        @notifiable_contacts = @user.contacts.notifiable(@checkin.shout)
        if needs_venue?
          @venue = @user.foursquare_client.venues.find(@checkin.venue_id)
        end
      else
        Rails.logger.warn("No user found for #{@checkin.user_id}")
      end
    end

    def notify_all
      return unless @checkin.is_complete?
      return if @user.nil?
      return if @notifiable_contacts.empty?

      # send the sms to the contacts
      send_sms(build_sms_messages)

      # mark contacts as messaged
      @notifiable_contacts.mark_all_notified!(@checkin.id)
    end

    private

    # notify contacts
    def send_sms(messages)
      sms_client = SoInformed::Sms::ClientFactory.get_client
      @notifiable_contacts.location_display_grouped_phone_numbers.each do |type, phone_numbers|
        sms_client.process(messages[type], phone_numbers)
      end
    end

    # build message for all contacts location displays
    def build_sms_messages
      @notifiable_contacts.location_displays.inject({}) do |hash, type|
        message = Foursquare::CheckinMessageBuilder.from_checkin(@user.name, @checkin, @venue, type)
        hash[type] = message.get_message
        hash
      end
    end

    def needs_venue?
      @notifiable_contacts.location_displays.include? :link
    end
  end
end
