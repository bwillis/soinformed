class SessionsController < ApplicationController

  def callback
    code = params[:code]
    access_token = foursquare.access_token(code, callback_session_url)
    user = User.find_or_create_by_foursquare_user(access_token)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end