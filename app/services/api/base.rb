module API
  class Base
    def initialize(channel)
      @channel = channel
      @channel.init_store_session unless @channel.store_session_initiated?
    end
    attr_reader :channel

    def call(*args, &block)
      UnavailableStoreExceptionHandler.new(channel).run do
        execute(*args, &block)
      end
    end
  end
end

