class HomeController < ApplicationController
  def index
    @authorize_url = foursquare.authorize_url(callback_session_url)
  end

  def privacy

  end

  def about

  end
end