# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_ingredients_on_name  (name) UNIQUE
#
class Ingredient < ApplicationRecord
  # Holds all information relating to an overall ingredient itself, not related directly to a Recipe that it might be
  #   linked to

  has_many :step_ingredients, dependent: :destroy
  has_many :steps, through: :step_ingredients
  has_many :recipes, through: :steps

  validates :name, presence: true
  validates :name, uniqueness: true

  accepts_nested_attributes_for :step_ingredients
end
