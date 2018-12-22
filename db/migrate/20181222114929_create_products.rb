class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :channel, foreign_key: { on_delete: :cascade }
      t.string :remote_id, null: false
      t.string :title
      t.jsonb :variants, null: false, default: '{}'
      t.jsonb :options, null: false, default: '{}'
      t.jsonb :images, null: false, default: '{}'
      t.datetime :remote_created_at
      t.datetime :remote_updated_at
      t.datetime :remote_published_at

      t.timestamps
    end

    add_index :products, [:channel_id, :remote_id], unique: true
    add_index :products, :variants, using: :gin
    add_index :products, :options, using: :gin
    add_index :products, :images, using: :gin
  end
end
