class HomeController < ApplicationController
  def index
    if current_user
      render :edit and return
    end
    @authorize_url = foursquare_authorize_url
  end

  def edit

  end

  def privacy

  end

  def about

  end
end