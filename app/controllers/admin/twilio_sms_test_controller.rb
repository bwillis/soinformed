module Admin
  class TwilioSmsTestController < Admin::BaseController
    def new
      @sms = SoInformed::Sms::SmsData.default(current_user.contacts.first.phone_number)
    end
  end
end
