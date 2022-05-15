# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint           not null, primary key
#  ancestry    :string
#  description :text
#  name        :string           not null
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_ingredients_on_ancestry          (ancestry)
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

  validates :name, :user, presence: true
  validates :name, uniqueness: {
    scope: [:user_id],
  }
  validates :slug, uniqueness: true

  friendly_id :slug_candidates, use: %i[slugged scoped history], scope: [:user]

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

  # Provides alternative values to FriendlyId slug generation to avoid collisions across users with identically
  #   named resources
  #
  # @return [Array]
  def slug_candidates
    [
      :name,
      # Produces a small alphanumeric String to append to the end of the slug. As it is small, collisions may still be
      #   possible, but very unlikely at current scale.
      [:name, -> { SecureRandom.urlsafe_base64(6) }]
    ]
  end

  # Determines if current Ingredient is the 'canonical' ingredient representing the main for the of the resource that
  #   other user-generated resources may point to
  def canonical?
    is_root?
  end
end
