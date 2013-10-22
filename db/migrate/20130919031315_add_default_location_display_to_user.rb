class AddDefaultLocationDisplayToUser < ActiveRecord::Migration
  def change
    add_column :users, :default_location_display, :string, :default => "text"
  end
end
