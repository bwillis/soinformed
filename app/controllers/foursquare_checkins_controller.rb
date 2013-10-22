class FoursquareCheckinsController < ApplicationController

  skip_before_filter :ensure_authenticated_user
  skip_before_filter :verify_authenticity_token, :only => :create
  before_filter :verify_foursquare_push_secret, :only => :create

  def create
    checkin_data = ActiveSupport::JSON.decode(checkin_params[:checkin])
    checkin = SoInformed::Foursquare::CheckinCompact.new(checkin_data)
    SoInformed::CheckinInformer.new(checkin).notify_all
    head :ok
  end

  private

  def verify_foursquare_push_secret
    if checkin_params[:secret] != Settings.app_push_secret && !Rails.env.development?
      Rails.logger.warn("Invalid foursquare push secret request.")
      render :file => "public/401.html", :status => :unauthorized and return
    end
  end

  def checkin_params
    params.permit(:checkin, :secret, :utf8)
  end
end