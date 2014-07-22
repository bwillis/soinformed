class SessionsController < ApplicationController

  skip_before_filter :ensure_authenticated_user, :only => :callback

  def callback
    user_session.authenticate(auth_params[:code], callback_session_url)
    redirect_to contacts_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def auth_params
    params.permit(:code)
  end
end
