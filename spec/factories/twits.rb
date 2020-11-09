require "faker"

FactoryBot.define do
  image = Rack::Test::UploadedFile.new("spec/support/assets/sample.png", "image/png")
  factory :twit do
    body { Faker::String.random(length: 1..280).tr("\u0000", "") }
    user { create(:user) }
    images { [image, image, image, image] }

    trait :too_many_images do
      images { [image, image, image, image, image] }
    end

    trait :six_mb_image do
      images { [Rack::Test::UploadedFile.new("spec/support/assets/6mb_image.jpg", "image/jpg")] }
    end
  end
end
