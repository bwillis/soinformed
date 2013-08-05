class SessionsController < ApplicationController

  def callback
    user_session.authenticate(params[:code])
    redirect_to contacts_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end