class ChangeProductJsonbColumnsDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :products, :variants, []
    change_column_default :products, :options, []
    change_column_default :products, :images, []
  end
end
