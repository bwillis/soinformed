module SoInformed
  class BaseApp
    attr_reader :updated_at
    def initialize
      @updated_at = Time.now
    end
  end
end