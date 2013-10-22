module Admin
  class TwilioSmsTestController < Admin::BaseController
    def new
      default_phone_number = current_user.contacts.first ? current_user.contacts.first.phone_number : "8675309"
      @sms = SoInformed::Sms::SmsData.default(default_phone_number)
    end
  end
end
