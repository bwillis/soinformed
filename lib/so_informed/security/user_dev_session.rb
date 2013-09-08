module SoInformed
  module Security
    class UserDevSession < UserSession
      def authenticate(code)
        user = User.where(:uid => "dev").first_or_create!(:uid => "dev", :token => "dev", :name => "Fake Foursquare User")
        user.last_signed_in_at = Time.now
        user.save
        @session[:user_id] = user.id
      end

      def authenticated?
        @session[:user_id]
      end

      def authentication_path
        @callback
      end

      def admin?
        authenticated?
      end
    end
  end
end
