class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user
  helper_method :authentication_path

  prepend_before_filter :ensure_authenticate_user

  private

  def current_user
    user_session.user
  end

  def authentication_path
    user_session.authentication_path
  end

  def user_session
    @user_session ||= if Rails.env.development?
      SoInformed::UserDevSession.new(session, callback_session_url)
    else
      SoInformed::UserSession.new(session, callback_session_url)
    end
  end

  def ensure_authenticate_user
    unless user_session.authenticated?
      flash[:error] = "You need to login to do that."
      redirect_to root_path
    end
  end
end
