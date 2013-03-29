class User < ActiveRecord::Base

  has_many :phone_numbers

  def self.find_or_create_by_foursquare_user(foursquare_user, token)
    uid = foursquare_user.id
    user = find_by_uid(uid) || User.new
    user.uid = uid
    user.token = token
    user.save!
    user
  end
end
