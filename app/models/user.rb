class User < ActiveRecord::Base

  has_many :contacts

  def self.find_or_create_by_foursquare_user(token)
    foursquare = Foursquare::Base.new(token)
    foursquare_user ||= foursquare.users.find("self")
    uid = foursquare_user.id
    user = find_by_uid(uid) || User.new
    user.uid = uid
    user.token = token
    user.name = "#{foursquare_user.json["firstName"]} #{foursquare_user.json["lastName"][0]}"
    user.save!
    user
  end

  def test_auth_token
    foursquare_user rescue false
  end

  def foursquare_user
    @foursquare ||= Foursquare::Base.new(token)
    @foursquare_user ||= @foursquare.users.find("self")
  end
end
