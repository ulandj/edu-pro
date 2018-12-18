class CreateChannelSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :channel_settings do |t|
      t.references :channel, foreign_key: true
      t.string :primary_location_id, null: false
      t.boolean :multi_location_enabled, default: false

      t.timestamps
    end
  end
end
