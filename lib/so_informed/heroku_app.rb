require 'heroku-api'

module SoInformed
  class HerokuApp < BaseApp

    attr_reader :updated_at

    def initialize(app_name, api_key, cache_updated_at)
      super(cache_updated_at)
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
