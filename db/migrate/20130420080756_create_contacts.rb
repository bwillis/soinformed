class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone_number
      t.string :notify_state
      t.datetime :notify_state_updated
      t.integer :user_id
      t.timestamps
    end
  end
end
