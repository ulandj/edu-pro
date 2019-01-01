class VariantSerializer < BaseSerializer
  attributes :id, :sku, :title, :price, :tax_included, :inventory_quantity,
             :remote_created_at, :remote_updated_at, :inventory_item_id, :fulfillment_service

  def tax_included
    object.dig('taxable')
  end

  def remote_created_at
    object.dig('created_at')
  end

  def remote_updated_at
    object.dig('updated_at')
  end
end
