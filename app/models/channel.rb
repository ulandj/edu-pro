class Channel < ApplicationRecord
  belongs_to :user
  belongs_to :settings, class_name: 'ChannelSetting'

  def init_store_session
    @shopify_session = ShopifyAPI::Session.new(shopify_url, shopify_access_token)
    ShopifyAPI::Base.activate_session(@shopify_session)
  end

  def has_store_session?
    !!@shopify_session
  end

  def deactivate!
    update(active: false)
  end

  def inactive?
    !active?
  end
end
