class RemovePhoneNumber1FromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :phone_number_1
  end

  def down
    add_column :users, :phone_number_1, :string
  end
end
