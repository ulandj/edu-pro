class ProductsImportingWorker
  include Sneakers::Worker
  from_queue 'product_importing',
             SNEAKERS_RETRY_CONFIG.merge(
               arguments: { 'x-dead-letter-exchange': 'product_importing-retry' }
             )

  def work(msg)
    parsed_msg = Oj.load(msg)
    channel = Channel.find(parsed_msg.fetch('channel_id'))
    ack! && return if channel.inactive?

    Products::Importer.new(channel, parsed_msg).run
    ack!
  rescue StandardError => exception
    Rails.logger.error("[ImportProductError]: #{exception.message}")
  end
end
