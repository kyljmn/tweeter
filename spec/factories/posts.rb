FactoryBot.define do
  factory :post do
    postable_id { 1 }
    postable_type { "MyString" }
  end
end
