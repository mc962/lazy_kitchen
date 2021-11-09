FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.unique.ingredient }
    description { Faker::Food.description }

    factory :ingredient_with_user do
      after(:build) do |ingredient|
        ingredient.user = FactoryBot.create(:user)
      end
    end
  end
end
