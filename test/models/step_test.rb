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
require "test_helper"

class StepTest < ActiveSupport::TestCase
  subject { FactoryBot.create(:step) }

  context 'associations' do
    should belong_to(:recipe)
    should have_many(:step_ingredients).dependent(:destroy)
    should have_many(:ingredients).through(:step_ingredients)

    context 'nested models' do
      should accept_nested_attributes_for(:step_ingredients)
    end
  end

  context 'validations' do
    should validate_presence_of(:order)
    should validate_presence_of(:instruction)
    should validate_presence_of(:recipe)
  end
end
