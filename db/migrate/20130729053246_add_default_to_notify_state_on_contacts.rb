class AddDefaultToNotifyStateOnContacts < ActiveRecord::Migration
  def change
    change_column :contacts, :notify_state, :string, :default => :never
  end
end
