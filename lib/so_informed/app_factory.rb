module SoInformed
  class AppFactory
    class << self
      attr_accessor :application
    end

    def self.get_application
      @application ||= case Rails.env.to_sym
                       when :development
                         SoInformed::DevApp.new
                       when :production
                         SoInformed::HerokuApp.new(
                             Rails.application.secrets.heroku_app_name,
                             Rails.application.secrets.heroku_app_key
                         )
                       else
                         raise "No application defined for rails environment #{Rails.env}"
                     end
    end

    def self.reset_application
      @application = nil
    end
  end
end