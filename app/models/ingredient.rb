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
#  index_ingredients_on_name_and_user_id  (name,user_id) UNIQUE
#  index_ingredients_on_slug              (slug) UNIQUE
#  index_ingredients_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# Holds all information relating to an overall ingredient itself, not related directly to a Recipe that
#   it might be linked to
class Ingredient < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  has_many :step_ingredients, dependent: :destroy
  has_many :steps, through: :step_ingredients
  has_many :recipes, through: :steps

  validates :name, presence: true
  validates :name, uniqueness: {
    scope: [:user_id]
  }

  accepts_nested_attributes_for :step_ingredients

  friendly_id :name, use: %i[slugged scoped history], scope: [:user]

  scope :managed, -> { includes(:user) }

  # Determines if a new slug should be generated. Currently this happens when the model is first created,
  # and when the name is updated
  #
  # @return [Boolean]
  # noinspection RubyInstanceMethodNamingConvention
  def should_generate_new_friendly_id?
    new_record? || name_changed?
  end
end
