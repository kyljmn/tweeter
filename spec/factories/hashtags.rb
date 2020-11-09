FactoryBot.define do
  factory :hashtag do
    name { Faker::String.random(length: 1..279).tr("\u0000", "") }
  end
end
