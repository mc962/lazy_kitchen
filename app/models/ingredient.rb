# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_ingredients_on_name     (name) UNIQUE
#  index_ingredients_on_slug     (slug) UNIQUE
#  index_ingredients_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Ingredient < ApplicationRecord
  # Holds all information relating to an overall ingredient itself, not related directly to a Recipe that it might be
  #   linked to

  extend FriendlyId

  belongs_to :user # , optional: true
  has_many :step_ingredients, dependent: :destroy
  has_many :steps, through: :step_ingredients
  has_many :recipes, through: :steps

  validates :name, presence: true
  validates :name, uniqueness: true

  accepts_nested_attributes_for :step_ingredients

  friendly_id :name, use: :slugged

  scope :managed, -> { includes(:user) }
end
