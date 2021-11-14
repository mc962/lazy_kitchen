# == Schema Information
#
# Table name: step_ingredients
#
#  id            :bigint           not null, primary key
#  amount        :decimal(, )      not null
#  condition     :string
#  unit          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ingredient_id :bigint           not null
#  step_id       :bigint           not null
#
# Indexes
#
#  index_step_ingredients_on_ingredient_id  (ingredient_id)
#  index_step_ingredients_on_step_id        (step_id)
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id)
#  fk_rails_...  (step_id => steps.id)
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
