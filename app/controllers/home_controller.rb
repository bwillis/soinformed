class HomeController < ApplicationController

  skip_before_filter :ensure_authenticate_user

  def index

  end

  def privacy

  end

  def about

  end
end