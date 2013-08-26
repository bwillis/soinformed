class TwilioSmsController < ApplicationController
  skip_before_filter :ensure_authenticated_user
  skip_before_filter :verify_authenticity_token, :only => :create
  before_filter :verify_twilio_push_secret, :only => :create


  def create
    phone_number = sms_params[:From]
    phone_number.gsub!("+1", "") # remove the +1 in the E.164 phone number

    # replies always go to the last checkin the contact recieved
    contact = Contact.find_last_messaged_contact(phone_number)

    head :ok and return unless contact

    user = contact.user
    message = sms_params[:Body]
    checkin_action = SoInformed::Foursquare::CheckinAction.new(user.foursquare_client, contact.last_checkin_id)
    checkin_action.post("#{contact.name} commented: #{message}", "https://soinformed.heroku.com/")

    head :ok
  end

  private

  def verify_twilio_push_secret
    if sms_params[:AccountSid] != Settings.twilio_app_sid && !Rails.env.development?
      Rails.logger.warn("Invalid twilio push secret request.")
      render :file => "public/401.html", :status => :unauthorized and return
    end
  end

  def sms_params
    params.permit(:AccountSid, :Body, :From)
  end
end