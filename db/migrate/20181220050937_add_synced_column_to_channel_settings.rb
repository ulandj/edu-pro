class AddSyncedColumnToChannelSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :channel_settings, :synced, :boolean, default: false
  end
end
