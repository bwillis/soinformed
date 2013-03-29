class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.integer :user_id, :null => false
      t.string :number, :null => false
      t.boolean :disabled, :default => false

      t.timestamps
    end
  end
end
