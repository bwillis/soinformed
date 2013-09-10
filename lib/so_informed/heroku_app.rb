require 'heroku-api'

module SoInformed
  class HerokuApp < BaseApp
    def initialize(app_name, api_key)
      super()
      @app_name = app_name
      @api_key  = api_key
    end

    def version
      @version ||= client.get_releases(@app_name).body.first["name"]
    end

    private

    def client
      @client = Heroku::API.new(:api_key => @api_key)
    end
  end
end
