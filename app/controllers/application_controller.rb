class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user
  helper_method :foursquare_authorize_url

  private

    def require_user
      unless current_user
        redirect_to root_path
      end
    end

    def current_user
      return nil if session[:user_id].blank?
      @current_user ||= begin
        user = User.find(session[:user_id])
        user.test_auth_token
        user
      rescue Foursquare::InvalidAuth
        nil
      end
    end

    def foursquare_authorize_url
      @authorize_url ||= foursquare.authorize_url(callback_session_url)
    end

    def foursquare
      @foursquare ||= Foursquare::Base.new(Settings.app_id, Settings.app_secret)
    end

    def verify_foursquare_push_secret
      if params[:secret] != Settings.app_push_secret
        render :file => "public/401.html", :status => :unauthorized and return
      end
    end
end
