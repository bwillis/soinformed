module SoInformed
  module Foursquare
    class CheckinData

      def self.object(user_id="1", shout="This is a soinformed test!")
        Checkin.new(self.default(user_id, shout))
      end

      def self.default(user_id="1", shout="This is a soinformed test!")
        {
            "id"             => "4e6fe1404b90c00032eeac34",
            "createdAt"      => 1315955008,
            "type"           => "checkin",
            "timeZoneOffset" => -240,
            "shout"          => shout,
            "user"           => {
                "id"           => user_id || "1",
                "firstName"    => "Jimmy",
                "lastName"     => "Foursquare",
                "photo"        => "https://foursquare.com/img/blank_boy.png",
                "gender"       => "male",
                "homeCity"     => "New York, NY",
                "relationship" => "self"
            },
            "venue"          => {
                "id"         => "4ab7e57cf964a5205f7b20e3",
                "name"       => "foursquare HQ",
                "contact"    => {
                    "twitter" => "foursquare"
                },
                "location"   => {
                    "address"    => "East Village",
                    "lat"        => 40.72809214560253,
                    "lng"        => -73.99112284183502,
                    "city"       => "New York",
                    "state"      => "NY",
                    "postalCode" => "10003",
                    "country"    => "USA"
                },
                "categories" => [
                    {
                        "id"         => "4bf58dd8d48988d125941735",
                        "name"       => "Tech Startup",
                        "pluralName" => "Tech Startups",
                        "shortName"  => "Tech Startup",
                        "icon"       => "https://foursquare.com/img/categories/building/default.png",
                        "parents"    => [
                            "Professional & Other Places",
                            "Offices"
                        ],
                        "primary"    => true
                    }
                ],
                "verified"   => true,
                "stats"      => {
                    "checkinsCount" => 7313,
                    "usersCount"    => 565,
                    "tipCount"      => 128
                },
                "url"        => "http://foursquare.com"
            }
        }
      end
    end
  end
end
