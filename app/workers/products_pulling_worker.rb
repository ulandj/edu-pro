class ProductsPullingWorker
  include Sneakers::Worker
  from_queue 'product_pulling'

  # TODO: make worker retryable
  def work(msg)
    parsed_msg = Oj.load(msg)
    channel = Channel.find(parsed_msg.fetch('channel_id'))
    ack! && return if channel.inactive?

    API::Products::Puller.new(channel).call
    ack!
  rescue StandardError => exception
    Rails.logger.error("[ImportProductError]: #{exception.message}")
    reject!
  end
end
