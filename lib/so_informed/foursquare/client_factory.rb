module SoInformed
  module Foursquare
    class ClientFactory
      def self.get_client(*args)
        puts "hello"
        if [:development, :test].include? Rails.env
          puts "returning logger client"
          LoggerClient.new(args)
        else
          Foursquare::Base.new(args)
        end
      end
    end
  end
end