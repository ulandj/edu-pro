class Product < ApplicationRecord
  belongs_to :channel

  def send_to_core!
    msg = { product: ProductSerializer.new(self).serializable_hash }
    opts = { to_queue: 'products', persistence: true }
    Sneakers.publish(msg.to_json, opts)
  end
end
