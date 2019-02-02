FactoryBot.define do
  factory :product do
    channel
    remote_id { FFaker::Random.seed }
  end
end
