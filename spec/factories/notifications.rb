FactoryBot.define do
  factory :notification do
    notifiable_id { 1 }
    notifiable_type { "MyString" }
    notified_id { 1 }
  end
end
