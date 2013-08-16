class FoursquareCheckinsController < ApplicationController

  skip_before_filter :ensure_authenticated_user
  skip_before_filter :verify_authenticity_token, :only => :create
  before_filter :verify_foursquare_push_secret, :only => :create

  def create
    checkin_data = ActiveSupport::JSON.decode(params['checkin'])
    checkin = SoInformed::Foursquare::Checkin.new(checkin_data)
    SoInformed::Informer.new(checkin).notify_all
    head :ok
  end

  private

  def verify_foursquare_push_secret
    if params[:secret] != Settings.app_push_secret && !Rails.env.development?
      Rails.logger.warn("Invalid foursquare push secret request.")
      render :file => "public/401.html", :status => :unauthorized and return
    end
  end
end