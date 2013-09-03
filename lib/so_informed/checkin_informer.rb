require 'active_support/core_ext/array/conversions'

module SoInformed
  class CheckinInformer

    attr_reader :user, :notifiable_contacts

    def initialize(checkin)
      @checkin = checkin
      if @user = User.find_by_uid(@checkin.user_id)
        @notifiable_contacts = @user.contacts.notifiable(@checkin.shout)
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

      # send a reply back to the users checkin so they
      # know they've mentioned someone
      if reply = build_foursquare_reply
        send_foursquare_checkin_reply(reply)
      end

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

    def send_foursquare_checkin_reply(message)
      checkin_action = SoInformed::Foursquare::CheckinAction.new(@user.foursquare_client, @checkin.id)
      checkin_action.reply(message, "https://soinformed.heroku.com/contacts")
    end

    # build message for all contacts location displays
    def build_sms_messages
      @notifiable_contacts.location_displays.inject({}) do |hash, type|
        message = Foursquare::CheckinMessageBuilder.from_checkin(@checkin, type)
        hash[type] = message.get_message
        hash
      end
    end

    def build_foursquare_reply
      names = @notifiable_contacts.notify_by_mention_names
      return false if names.empty?
      "#{@user.name} mentioned #{names.to_sentence} to tell them about this checkin!"
    end
  end
end
