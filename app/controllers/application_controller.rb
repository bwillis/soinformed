class ApplicationController < ActionController::Base

  include SoInformed::Security::ControllerMixin

  protect_from_forgery

  etag { SoInformed::AppFactory.get_application.version }
  etag { flash }
  etag { current_user.try :last_signed_in_at }
  etag { current_user.try :id }

  after_filter do
    if response.etag.nil? # no etag check occurred yet
      fresh_when(1)
    end
  end
end
