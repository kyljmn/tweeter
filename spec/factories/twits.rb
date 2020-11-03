require 'faker'

FactoryBot.define do
  factory :twit do
    body { Faker::String.random(length: 250) }
    user { FactoryBot.create :user }
  end
end
