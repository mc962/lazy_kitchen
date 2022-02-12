# frozen_string_literal: true

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

# Links an ingredient to a specific recipe step. Contains step specific information about an ingredient, such
#   as the condition of an ingredient (e.g. hot, cold, etc.) that is not a specific quality of that ingredient
class StepIngredient < ApplicationRecord
  belongs_to :step
  belongs_to :ingredient

  resourcify

  validates :amount, :step, :ingredient, presence: true
  validates_associated :ingredient

  accepts_nested_attributes_for :step, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :ingredient, reject_if: :all_blank, allow_destroy: true

  scope :managed, -> { includes(step: [recipe: [:user]]) }
end
