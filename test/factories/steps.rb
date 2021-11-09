FactoryBot.define do
  factory :step do
    order { Faker::Number.between(from: 1, to: 100) }
    instruction { Faker::TvShows::DrWho.quote }

    recipe { association :recipe_with_user }

    factory :step_with_ingredients do
      transient do
        step_ingredients_count { 3 }
      end

      after(:create) do |step, evaluator|
        FactoryBot.create_list(:step_ingredient, evaluator.step_ingredients_count, step: step)

        step.reload
      end
    end
  end
end
