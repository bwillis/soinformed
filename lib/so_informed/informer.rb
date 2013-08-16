module SoInformed
  class Informer
    def initialize(checkin)
      @checkin = checkin
      @user = User.find_by_uid(@checkin.user_id)
      @notifiable_contacts = @user.contacts.notifiable(@checkin.shout)
    end

    def notify_all
      return unless @checkin.is_complete?
      return if @user.nil?
      return if @notifiable_contacts.empty?

      send_sms(build_messages)

      # mark contacts as messaged
      @notifiable_contacts.mark_all_notified!
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
    def build_messages
      @notifiable_contacts.location_displays.inject({}) do |hash, type|
        message = Foursquare::MessageBuilder.from_checkin(@checkin, type)
        hash[type] = message.get_message
        hash
      end
    end
  end
end
