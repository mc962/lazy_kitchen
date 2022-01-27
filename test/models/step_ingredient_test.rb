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

require "test_helper"

class StepIngredientTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:step)
    should belong_to(:ingredient)

    context 'nested models' do
      should accept_nested_attributes_for(:step)
      should accept_nested_attributes_for(:ingredient)
    end
  end

  context 'validations' do
    should validate_presence_of(:amount)
    should validate_presence_of(:step)
    should validate_presence_of(:ingredient)
  end
end
