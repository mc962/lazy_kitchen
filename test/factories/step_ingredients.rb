# == Schema Information
#
# Table name: step_ingredients
#
#  id            :integer          not null, primary key
#  amount        :decimal(, )      not null
#  unit          :string
#  condition     :string
#  step_id       :integer          not null
#  ingredient_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_step_ingredients_on_ingredient_id  (ingredient_id)
#  index_step_ingredients_on_step_id        (step_id)
#

FactoryBot.define do
  factory :step_ingredient do
    amount { Faker::Number.between(from: 1, to: 10) }
    condition { Faker::Adjective.positive }
    unit { Faker::Food.metric_measurement }

    association :step
    ingredient {association :ingredient_with_user}
  end
end
