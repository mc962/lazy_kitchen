# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_ingredients_on_name_and_user_id  (name,user_id) UNIQUE
#  index_ingredients_on_slug              (slug) UNIQUE
#  index_ingredients_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
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
