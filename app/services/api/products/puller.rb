module API
  module Products
    class Puller < API::Base
      MAX_REQUEST_PAGE_SIZE = 250

      def execute
        (1..page_count).each do |page_index|
          product_list = fetch_product_list_page(product_pulling_criteria.merge(page: page_index, limit: MAX_REQUEST_PAGE_SIZE))
          message = {
            channel_id:   channel.id,
            product_list: product_list
          }
          if page_index == page_count
            message[:last_page] = true
            channel.update(products_successfully_fetched_at: Time.current)
          end

          enqueue_job_for_importing_product(message)
        end
      end

      def enqueue_job_for_importing_product(message)
        opts = { to_queue: 'product_importing', persistence: true }
        Sneakers.publish(message.to_json, opts)
      end

      protected

      def fetch_product_list_page(page_params)
        ShopifyAPI::Product.all(params: page_params)
      end

      def product_pulling_criteria
        updated_at_min = channel.reload.products_successfully_fetched_at
        return {} if updated_at_min.blank?

        { updated_at_min: updated_at_min.to_s }
      end

      def remote_product_count
        @remote_product_count ||= ShopifyAPI::Product.count(product_pulling_criteria)
      end

      def page_count
        @page_count ||= (remote_product_count / MAX_REQUEST_PAGE_SIZE.to_f).ceil
      end
    end
  end
end
