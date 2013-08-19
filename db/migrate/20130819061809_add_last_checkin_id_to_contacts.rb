class AddLastCheckinIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :last_checkin_id, :string
  end
end
