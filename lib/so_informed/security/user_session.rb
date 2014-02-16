module SoInformed
  module Security
    class UserSession
      def initialize(session, callback_url)
        @session  = session
        @callback = callback_url
      end

      def user
        return nil if @session[:user_id].blank?
        @current_user ||= begin
          User.find(@session[:user_id])
        rescue
          nil
        end
      end

      def authenticated?
        user.present?
      end

      def authenticate(code)
        access_token       = foursquare.access_token(code, @callback)
        user               = User.find_or_create_by_foursquare_user(access_token)
        @session[:user_id] = user.id
      end

      def authentication_path
        @authorize_url ||= foursquare.authorize_url(@callback)
      end

      def admin?
        authenticated? && user.id == 1
      end

      private

      def foursquare
        @foursquare ||= ::Foursquare::Base.new(
            Rails.application.secrets.foursquare_app_id,
            Rails.application.secrets.foursquare_app_secret
        )
      end
    end
  end
end
