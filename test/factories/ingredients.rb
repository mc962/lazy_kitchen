FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.unique.ingredient }
    description { Faker::Food.description }
  end
end
