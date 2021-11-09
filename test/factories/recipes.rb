FactoryBot.define do
  factory :recipe do
    name { Faker::Food.unique.dish }
    image_url { Faker::Avatar.image }
    description { Faker::Food.description }
    publicly_accessible { Faker::Boolean.boolean }

    association :user

    factory :recipe_with_steps do
      transient do
        steps_count { 5 }
      end

      after(:create) do |recipe, evaluator|
        FactoryBot.create_list(:step, evaluator.steps_count, recipe: recipe)

        recipe.reload
      end
    end

    factory :recipe_with_citations do
      transient do
        citations_count { 5 }
      end

      after(:create) do |recipe, evaluator|
        FactoryBot.create_list(:citation, evaluator.citations_count, recipe: recipe)

        recipe.reload
      end
    end

    factory :recipe_with_user do
      after(:build) do |recipe|
        recipe.user = FactoryBot.create(:user)
      end
    end
  end
end
