module Products
  class Importer
    def initialize(channel, message)
      @channel = channel
      @product_list = message.dig('product_list')
      @last_page = message.dig('last_page')
    end
    attr_reader :channel, :product_list, :last_page

    def run
      product_list.each { |shopify_product| import_product(shopify_product) }
      channel.update(products_successfully_pulled_at: Time.current) if last_page
    end

    protected

    def import_product(shopify_product)
      base_product_filter = Product.where(channel_id: channel.id, remote_id: shopify_product.fetch('id'))
      product = base_product_filter&.first
      return if product && product.remote_updated_at >= DateTime.parse(shopify_product.dig('updated_at'))

      base_product_filter.first_or_create.tap do |product|
        product.title = shopify_product.dig('title')
        product.remote_created_at = shopify_product.dig('created_at')
        product.remote_updated_at = shopify_product.dig('updated_at')
        product.remote_published_at = shopify_product.dig('published_at')
        product.variants = shopify_product.dig('variants') || []
        product.options = shopify_product.dig('options') || []
        product.images = shopify_product.dig('images') || []
        if product.changed?
          product.synced = false
          product.save!
          product.send_to_core!
        end
      end
    end
  end
end
