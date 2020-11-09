FactoryBot.define do
  factory :twit_hashtag do
    twit_id { twit.id }
    hashtag_id { hashtag.id }

    transient do
      twit { create(:twit) }
      hashtag { create(:hashtag) }
    end
  end
end
