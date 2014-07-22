class User < ActiveRecord::Base

  has_many :contacts, -> { order "updated_at DESC" }

  validates_presence_of :name

  def self.find_or_create_by_foursquare_user(code, url)
    foursquare = Foursquare::Base.new(
        client_id:     Rails.application.secrets.foursquare_app_id,
        client_secret: Rails.application.secrets.foursquare_app_secret
    )
    token = foursquare.access_token(params["code"], url)

    client_foursquare = SoInformed::Foursquare::ClientFactory.get_client(access_token: token)
    foursquare_user ||= client_foursquare.users.find("self")
    uid = client_foursquare.id
    user = find_by_uid(uid) || User.new
    user.last_signed_in_at = Time.now
    user.uid = uid
    user.token = token
    unless user.name
      user.name = "#{foursquare_user.json["firstName"]} #{foursquare_user.json["lastName"][0]}"
    end
    user.save!
    user
  end

  def test_auth_token
    foursquare_user rescue false
  end

  def foursquare_user
    @foursquare_user ||= foursquare_client.users.find("self")
  end

  def foursquare_client
    @foursquare ||= SoInformed::Foursquare::ClientFactory.get_client(access_token: token)
  end
end
