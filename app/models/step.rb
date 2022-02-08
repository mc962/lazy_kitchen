# frozen_string_literal: true

# == Schema Information
#
# Table name: steps
#
#  id          :integer          not null, primary key
#  order       :integer          not null
#  instruction :text             not null
#  recipe_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_steps_on_recipe_id  (recipe_id)
#

# Contains information for a specific recipe step
class Step < ApplicationRecord
  include ActiveStoragePath

  belongs_to :recipe
  has_many :step_ingredients, dependent: :destroy
  has_many :ingredients, through: :step_ingredients
  has_many_attached_with :gallery_pictures, path: -> { "#{Rails.application.config.x.resource_prefix}/steps" }

  validates :order, :instruction, :recipe, presence: true
  validates_associated :step_ingredients

  accepts_nested_attributes_for :step_ingredients, reject_if: :all_blank, allow_destroy: true

  scope :managed, -> { includes(recipe: [:user]) }
end
