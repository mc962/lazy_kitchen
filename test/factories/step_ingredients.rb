FactoryBot.define do
  factory :step_ingredient do
    amount { Faker::Number.between(from: 1, to: 10) }
    condition { Faker::Adjective.positive }
    unit { Faker::Food.metric_measurement }

    association :step
    ingredient {association :ingredient_with_user}
  end
end
