class TwilioSmsController < ApplicationController
  skip_before_filter :ensure_authenticated_user
  skip_before_filter :verify_authenticity_token, :only => :create
  before_filter :verify_twilio_push_secret, :only => :create

  def create
    sms = SoInformed::Sms::Sms.new(sms_params[:From], sms_params[:Body])
    SoInformed::SmsInformer.new(sms).notify_all
    render :xml => '<?xml version="1.0" encoding="UTF-8"?><Response></Response>'
  end

  private

  def verify_twilio_push_secret
    if sms_params[:AccountSid] != Rails.application.secrets.twilio_app_sid && !Rails.env.development?
      Rails.logger.warn("Invalid twilio push secret request.")
      render :file => "public/401.html", :status => :unauthorized and return
    end
  end

  def sms_params
    params.permit(:AccountSid, :Body, :From, :utf8)
  end
end
