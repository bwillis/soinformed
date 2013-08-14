class AddMessageStatsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :message_count, :integer, :default => 0
    add_column :contacts, :last_message_at, :datetime
  end
end
