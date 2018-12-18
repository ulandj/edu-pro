class Channel < ApplicationRecord
  belongs_to :user
  belongs_to :channel_setting

  def init_session
    shopify_session = ShopifyAPI::Session.new(shopify_url, shopify_access_token)
    ShopifyAPI::Base.activate_session(shopify_session)
  end
end
