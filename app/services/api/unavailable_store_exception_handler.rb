module API
  class UnavailableStoreExceptionHandler
    def initialize(channel)
      @channel = channel
    end
    attr_reader :channel

    def run
      yield
    rescue ActiveResource::UnauthorizedAccess, ActiveResource::ResourceNotFound, ActiveResource::ForbiddenAccess => exception
      return if channel.reload.inactive?

      channel.deactivate!
    rescue StandardError
      raise
    end
  end
end

