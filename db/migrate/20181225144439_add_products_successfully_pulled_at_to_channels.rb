class AddProductsSuccessfullyPulledAtToChannels < ActiveRecord::Migration[5.2]
  def change
    add_column :channels, :products_successfully_pulled_at, :datetime

    add_index :channels, :products_successfully_pulled_at
  end
end
