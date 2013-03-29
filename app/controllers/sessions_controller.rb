class SessionsController < ApplicationController

  def new
    return redirect_to root_path if current_user
    @authorize_url = foursquare_authorize_url
  end
  
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