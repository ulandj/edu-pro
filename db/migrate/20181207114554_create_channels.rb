class CreateChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :channels do |t|
      t.references :user, foreign_key: true

      t.string :name
      t.boolean :active, default: false, null: false
      t.string :url
      t.string :shopify_url
      t.string :shopify_access_token
      t.string :token

      t.timestamps
    end

    add_index :channels, :token, unique: true
  end
end
