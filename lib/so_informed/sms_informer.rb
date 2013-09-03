module SoInformed
  class SmsInformer
    def initialize(sms)
      @sms = sms
    end

    def notify_all
      from = @sms.from.gsub("+1","")
      body = @sms.body
      contact = Contact.find_last_messaged_contact(from)
      return unless contact
      user = contact.user
      message = SoInformed::Foursquare::CheckinCommentMessageBuilder.new(contact.name, body)
      checkin_action = SoInformed::Foursquare::CheckinAction.new(user.foursquare_client, contact.last_checkin_id)
      checkin_action.post(message.get_message, message.get_url)
    end
  end
end
