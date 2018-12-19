class StoreSettingsFetcherWorker
  include Sneakers::Worker
  from_queue "pull_channel_settings"

  # @param [JSON] msg
  # "{\"channel_id\": 1231}"
  def work(msg)
    parsed_msg = Oj.load(msg)
    channel = Channel.find(parsed_msg.fetch('channel_id'))
    ack! and return if channel.inactive?

    API::Settings::Puller.new(channel).call
    ack!
  rescue => exception
    Rails.logger.error("[CreateChannelSettings]: #{exception.message}")
    reject!
  end
end