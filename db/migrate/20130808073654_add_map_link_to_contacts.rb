class AddMapLinkToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :location_display, :string, :default => "text"
  end
end
