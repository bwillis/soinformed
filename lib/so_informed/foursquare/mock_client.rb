module SoInformed
  module Foursquare
    class MockClient

      attr_reader :client_token

      def initialize(token)
        @client_token = token
      end

      def users

      end

      def post(url, params)
      end

      def get(url, params)
      end
    end
  end
end