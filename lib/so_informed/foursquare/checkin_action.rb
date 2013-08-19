module SoInformed
  module Foursquare
    class CheckinAction
      def initialize(foursquare_client, checkin_id)
        @foursquare_client = foursquare_client
        @checkin_id = checkin_id
      end

      def reply(message, url)
        @foursquare_client.post("checkins/#{@checkin_id}/reply", {:text => message, :url => url})
      end

      def post(message, url)
        @foursquare_client.post("checkins/#{@checkin_id}/addpost", {:text => message, :url => url})
      end
    end
  end
end
