class AddSoPhoneNumberToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :phone_number_1, :string
  end

  def self.down
    remove_column :users, :phone_number_1
  end
end
