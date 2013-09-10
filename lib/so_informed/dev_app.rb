
module SoInformed
  class DevApp < BaseApp
    def version
      "development-#{Time.now}"
    end
  end
end
