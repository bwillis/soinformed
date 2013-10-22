class AddIdIndexToContacts < ActiveRecord::Migration
  def change
    add_index :contacts, :id
  end
end
