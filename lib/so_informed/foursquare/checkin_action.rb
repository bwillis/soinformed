module SoInformed
  module Foursquare
    class CheckinAction
      def initialize(foursquare_client, checkin_id)
        @foursquare_client = foursquare_client
        @checkin_id = checkin_id
      end

      # This is a special message directed to an app checkin
      def reply(message, url)
        @foursquare_client.post("checkins/#{@checkin_id}/reply", {:text => message, :url => url, :v => "20130828"})
      end

      # This is a special post that looks just like a comment tagged with 'via app name'
      def post(message, url)
        @foursquare_client.post("checkins/#{@checkin_id}/addpost", {:text => message, :url => url, :v => "20130828"})
      end
    end
  end
end
