module SoInformed
  module Foursquare
    class CheckinCompact

      attr_reader :username, :user_id, :venue_id, :venue_name, :address, :shout, :id

      def initialize(data)
        @id           = data['id']
        @username     = "#{data['user']['firstName']} #{data['user']['lastName']}"
        @user_id      = data['user']['id']
        @venue_name   = data['venue']['name']
        @venue_id     = data['venue']['id']
        @shout        = data['shout']

        address       = data['venue']['location']['address']
        cross_street  = data['venue']['location']['crossStreet']
        @address = "#{address}#{cross_street ? " by #{cross_street}" : ""}" if address
      end

      def has_shout?
        @shout.present?
      end

      def has_address?
        @address.present?
      end

      def is_complete?
        @user_id.present? &&
          @username.present? &&
          @venue_name.present?
      end
    end
  end
end