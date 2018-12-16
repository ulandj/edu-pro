FactoryBot.define do
  factory :channel do
    user
    name { FFaker::Name.first_name }
    active { false }
    sequence(:url) { |n| "some#{n}.myshopify.com" }
    sequence(:shopify_url) { |n| "some#{n}.myshopify.com" }
    shopify_access_token { SecureRandom.hex }
    token { SecureRandom.hex }
  end

  factory :shopify_channel, parent: :channel do
    active { true }
    shopify_url { 'ulan-store.myshopify.com' }
    shopify_access_token { ENV['SHOPIFY_ACCESS_TOKEN'] }
  end
end
