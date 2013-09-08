
module SoInformed
  class DevApp < BaseApp
    def updated_at
      Time.now
    end

    def version
      "development"
    end
  end
end
