# == Schema Information
#
# Table name: ingredients
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  slug        :string
#  ancestry    :string
#
# Indexes
#
#  index_ingredients_on_ancestry          (ancestry)
#  index_ingredients_on_name_and_user_id  (name,user_id) UNIQUE
#  index_ingredients_on_slug              (slug) UNIQUE
#  index_ingredients_on_user_id           (user_id)
#

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
