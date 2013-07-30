module SoInformed
  module Foursquare
    class Checkin
      attr_reader :username, :user_id, :venue_name, :address, :shout
      def initialize(data)
        @username     = "#{checkin['user']['firstName']} #{checkin['user']['lastName']}"
        @user_id      = checkin['user']['id']
        @venue_name   = checkin['venue']['name']

        address       = checkin['venue']['location']['address']
        cross_street  = checkin['venue']['location']['crossStreet']
        @address = " (#{address}#{cross_street ? " by #{cross_street}" : ""})" if address

        @shout        = checkin['shout']
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