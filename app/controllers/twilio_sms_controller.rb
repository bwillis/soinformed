class TwilioSmsController < ApplicationController
  skip_before_filter :ensure_authenticated_user
  skip_before_filter :verify_authenticity_token, :only => :create
  before_filter :verify_twilio_push_secret, :only => :create

  def create
    SoInformed::SmsInformer.new(sms_params[:From], sms_params[:Body]).notify_all
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