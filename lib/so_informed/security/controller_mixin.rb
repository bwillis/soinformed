module SoInformed
  module Security
    module ControllerMixin

      def self.included(base)
        base.helper_method :current_user
        base.helper_method :authentication_path
        base.helper_method :admin?
        base.helper_method :dev_session_enabled?
        base.before_filter :ensure_authenticated_user
      end

      def admin?
        user_session.admin?
      end

      def current_user
        user_session.user
      end

      def authentication_path
        user_session.authentication_path
      end

      def user_session(reload=false)
        @user_session = nil if reload
        @user_session ||= if Rails.env.development? && dev_session_enabled?
                            UserDevSession.new(session, callback_session_url)
                          else
                            UserSession.new(session, callback_session_url)
                          end
      end

      def dev_session_enabled?
        !cookies.has_key? :no_dev_mode_authentication
      end

      def set_dev_session_enabled(enabled)
        if enabled
          cookies.delete(:no_dev_mode_authentication)
        else
          reset_session
          user_session(true)
          cookies[:no_dev_mode_authentication] = true
        end
      end

      def ensure_authenticated_user
        unless user_session.authenticated?
          redirect_to root_path, :alert => "You need to login to do that."
        end
      end

      def ensure_admin
        raise_fake_route_not_found unless user_session.admin?
      end

      def raise_fake_route_not_found
        raise ActionController::RoutingError.new("No route matches [#{request.method}] \"#{request.path}\"")
      end
    end
  end
end