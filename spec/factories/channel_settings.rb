FactoryBot.define do
  factory :channel_setting do
    channel
    primary_location_id { rand(10**10).to_s }
    multi_location_enabled { false }
  end
end
