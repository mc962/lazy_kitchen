# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  slug        :string
#  ancestry    :string
#
# Indexes
#
#  index_ingredients_on_ancestry          (ancestry)
#  index_ingredients_on_name_and_user_id  (name,user_id) UNIQUE
#  index_ingredients_on_slug              (slug) UNIQUE
#  index_ingredients_on_user_id           (user_id)
#

# Holds all information relating to an overall ingredient itself, not related directly to a Recipe that
#   it might be linked to
class Ingredient < ApplicationRecord
  include ActiveStoragePath

  extend FriendlyId

  belongs_to :user
  has_many :step_ingredients, dependent: :destroy
  has_many :steps, through: :step_ingredients
  has_many :recipes, through: :steps
  has_many :notes, as: :notable, class_name: 'Note'
  has_many_attached_with :gallery_pictures, path: -> { "#{Rails.application.config.x.resource_prefix}/ingredients" }

  has_ancestry orphan_strategy: :rootify, touch: true

  resourcify

  validates :name, presence: true
  validates :name, uniqueness: {
    scope: [:user_id]
  }

  friendly_id :name, use: %i[slugged scoped history], scope: [:user]

  scope :managed, -> { includes(:user) }

  accepts_nested_attributes_for :notes, reject_if: :all_blank, allow_destroy: true

  # Determines if a new slug should be generated. Currently this happens when the model is first created,
  # and when the name is updated
  #
  # @return [Boolean]
  # noinspection RubyInstanceMethodNamingConvention
  def should_generate_new_friendly_id?
    new_record? || name_changed?
  end

  def canonical?
    is_root?
  end
end
