# == Schema Information
#
# Table name: recipes
#
#  id                  :bigint           not null, primary key
#  description         :text
#  image_url           :string
#  name                :string           not null
#  publicly_accessible :boolean          default(FALSE), not null
#  slug                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_recipes_on_name     (name) UNIQUE
#  index_recipes_on_slug     (slug) UNIQUE
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  subject { FactoryBot.create(:recipe) }

  context :associations do
    should belong_to(:user)
    should have_many(:steps)
    should have_many(:ingredients).through(:steps)
    should have_many(:citations)

    context :nested_models do
      should accept_nested_attributes_for(:steps)
      should accept_nested_attributes_for(:citations)
    end
  end

  context :validations do
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
  end
end
