# == Schema Information
#
# Table name: recipes
#
#  id                  :bigint           not null, primary key
#  description         :text
#  name                :string           not null
#  publicly_accessible :boolean          default(FALSE), not null
#  slug                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_recipes_on_name_and_user_id  (name,user_id) UNIQUE
#  index_recipes_on_slug              (slug) UNIQUE
#  index_recipes_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish + SecureRandom.uuid }
    description { Faker::Food.description }
    publicly_accessible { Faker::Boolean.boolean }

    association :user

    factory :recipe_with_steps do
      transient do
        steps_count { 5 }
      end

      after(:create) do |recipe, evaluator|
        recipe.reload
        FactoryBot.create_list(:step_with_ingredients, evaluator.steps_count, recipe: recipe)
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
