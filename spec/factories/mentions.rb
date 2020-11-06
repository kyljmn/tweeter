FactoryBot.define do
  factory :mention do
    twit_id { twit.id }
    user_id { user.id }

    transient do
      twit { create(:twit) }
      user { create(:user) }
    end
  end
end
