class AddSyncedFieldToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :synced, :boolean, default: false
  end
end
