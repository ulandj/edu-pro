class AddProductsSuccessfullyFetchedAtToChannels < ActiveRecord::Migration[5.2]
  def change
    add_column :channels, :products_successfully_fetched_at, :datetime

    add_index :channels, :products_successfully_fetched_at
  end
end
