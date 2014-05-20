module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.includes(:contacts).order(:created_at).load
      fresh_when(@users)
    end
  end
end
