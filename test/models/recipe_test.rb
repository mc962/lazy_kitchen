# == Schema Information
#
# Table name: recipes
#
#  id                  :integer          not null, primary key
#  name                :string           not null
#  description         :text
#  publicly_accessible :boolean          default("false"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  slug                :string
#
# Indexes
#
#  index_recipes_on_name_and_user_id  (name,user_id) UNIQUE
#  index_recipes_on_slug              (slug) UNIQUE
#  index_recipes_on_user_id           (user_id)
#

require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  subject { FactoryBot.create(:recipe) }

  context 'associations' do
    should belong_to(:user)
    should have_many(:steps).dependent(:destroy)
    should have_many(:ingredients).through(:steps)
    should have_many(:citations)

    context 'nested models' do
      should accept_nested_attributes_for(:steps)
      should accept_nested_attributes_for(:citations)
    end
  end

  context 'validations' do
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name).scoped_to(:user_id)
  end

  context 'queries' do
    should 'only get recipes that may be accessed publicly with #publicly_accessible' do
      public_recipes = FactoryBot.create_list(:recipe, 2, publicly_accessible: true)
      _private_recipes = FactoryBot.create_list(:recipe, 3, publicly_accessible: false)

      assert Recipe.publicly_accessible.count == public_recipes.size
    end
  end
end
