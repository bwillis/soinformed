module Admin
  class SettingsController < Admin::BaseController

    def index
      @application = SoInformed::AppFactory.get_application
    end

    def create
      set_dev_session_enabled(params[:dev_session_enabled])
      if user_session.authenticated?
        redirect_to admin_settings_path
      else
        redirect_to root_path
      end
    end
  end
end