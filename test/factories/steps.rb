# == Schema Information
#
# Table name: steps
#
#  id          :bigint           not null, primary key
#  instruction :text             not null
#  order       :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  recipe_id   :bigint           not null
#
# Indexes
#
#  index_steps_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#

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
