class HomeController < ApplicationController
  def index
    @authorize_url = foursquare_authorize_url
  end

  def privacy

  end

  def about

  end
end