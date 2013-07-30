class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user
  helper_method :authentication_path

  private

  def current_user
    user_session.user
  end

  def authentication_path
    user_session.authentication_path
  end

  def user_session
    @user_session ||= SoInformed::UserSession.new(session, callback_session_url)
  end
end
