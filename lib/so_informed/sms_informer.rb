module SoInformed
  class SmsInformer
    def initialize(phone_number, message)
      phone_number.gsub!("+1", "")
      @phone_number = phone_number; @message = message
    end

    def notify_all
      contact = Contact.find_last_messaged_contact(@phone_number)
      return unless contact
      user = contact.user
      message = SoInformed::Foursquare::CheckinCommentMessageBuilder.new(contact.name, @message)
      checkin_action = SoInformed::Foursquare::CheckinAction.new(user.foursquare_client, contact.last_checkin_id)
      checkin_action.post(message.get_message, message.get_url)
    end
  end
end
