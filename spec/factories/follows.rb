FactoryBot.define do
  factory :follow do
    follower_id { user.id }
    following_id { user2.id }

    transient do
      user { create(:user) }
      user2 { create(:user) }
    end
  end
end
