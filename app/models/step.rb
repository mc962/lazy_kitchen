# frozen_string_literal: true

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
class Step < ApplicationRecord
  # Contains information for a specific recipe step

  belongs_to :recipe
  has_many :step_ingredients, dependent: :destroy
  has_many :ingredients, through: :step_ingredients

  validates :order, :instruction, :recipe, presence: true

  accepts_nested_attributes_for :step_ingredients

  scope :managed, -> { includes(recipe: [:user]) }
end
