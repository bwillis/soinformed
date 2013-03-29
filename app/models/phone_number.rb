class PhoneNumber < ActiveRecord::Base
  attr_accessible :disabled, :number, :user_id

  scope :active, where(:disabled => false)
end
