module API
  module Settings
    class Puller < API::Base
      def execute
        ChannelSetting.where(channel_id: channel.id).first_or_create! do |setting|
          setting.primary_location_id = current_setting.primary_location_id
          setting.multi_location_enabled = current_setting.multi_location_enabled
        end
      end

      private

      def current_setting
        @current_setting ||= ShopifyAPI::Shop.current
      end
    end
  end
end
