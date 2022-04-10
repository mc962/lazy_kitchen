# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint           not null, primary key
#  ancestry    :string
#  description :text
#  name        :string           not null
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_ingredients_on_ancestry          (ancestry)
#  index_ingredients_on_name_and_user_id  (name,user_id) UNIQUE
#  index_ingredients_on_slug              (slug) UNIQUE
#  index_ingredients_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  subject { FactoryBot.create(:ingredient_with_user) }

  context 'associations' do
    should belong_to(:user)
    should have_many(:step_ingredients).dependent(:destroy)
    should have_many(:steps)
    should have_many(:recipes).through(:steps)
  end

  context 'validations' do
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name).scoped_to(:user_id)
  end
end
