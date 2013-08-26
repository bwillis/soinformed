module SoInformed
  module Foursquare
    class ClientFactory
      def self.get_client(*args)
        if [:development, :test].include? Rails.env.to_sym
          LoggerClient.new(args)
        else
          ::Foursquare::Base.new(args)
        end
      end
    end
  end
end