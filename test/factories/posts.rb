FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyText" }
    published_at { "2022-02-13" }
    modified_at { "2022-02-13" }
    published { false }
    user { nil }
  end
end
