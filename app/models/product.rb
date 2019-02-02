class Product < ApplicationRecord
  belongs_to :channel

  validates :remote_id, uniqueness: { scope: :channel_id }, presence: true, case_sensitive: false

  def send_to_core!
    msg = { product: ProductSerializer.new(self).serializable_hash }
    opts = { to_queue: 'products', persistence: true }
    Sneakers.publish(msg.to_json, opts)
  end
end
