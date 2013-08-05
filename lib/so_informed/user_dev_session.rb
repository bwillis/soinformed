module SoInformed
  class UserDevSession < UserSession
    def user
      @current_user ||= if authenticated?
        User.where(:uid => "dev").first_or_create!(:uid => "dev", :token => "dev", :name => "Fake Foursquare User")
      else
        nil
      end
    end

    def authenticate(code)
      @session[:user_id] = 1
      @session[:user_id] = user.id
    end

    def authenticated?
      @session[:user_id]
    end

    def authentication_path
      @callback
    end
  end
end
