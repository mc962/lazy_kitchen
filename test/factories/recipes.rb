FactoryBot.define do
  factory :recipe do
    name { Faker::Food.unique.dish }
    image_url { Faker::Avatar.image }
    description { Faker::Food.description }
    publicly_accessible { Faker::Boolean.boolean }
  end
end
