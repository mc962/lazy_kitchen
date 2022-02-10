# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id                  :integer          not null, primary key
#  name                :string           not null
#  description         :text
#  publicly_accessible :boolean          default("false"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  slug                :string
#
# Indexes
#
#  index_recipes_on_name_and_user_id  (name,user_id) UNIQUE
#  index_recipes_on_slug              (slug) UNIQUE
#  index_recipes_on_user_id           (user_id)
#

# Holds all information relating to an overall recipe itself
class Recipe < ApplicationRecord
  extend FriendlyId
  include ActiveStoragePath

  has_many :steps, lambda {
    # Recipe's steps should be displayed in order
    order(order: :asc)
  }, dependent: :destroy
  has_many :ingredients, through: :steps
  has_many :citations
  belongs_to :user
  has_many :notes, as: :notable, class_name: 'Note'
  has_one_attached_with :primary_picture, path: -> { "#{Rails.application.config.x.resource_prefix}/recipes" }
  has_many_attached_with :gallery_pictures, path: -> { "#{Rails.application.config.x.resource_prefix}/recipes" }

  validates :name, presence: true
  validates :name, uniqueness: {
    scope: [:user_id]
  }
  validates_associated :steps, :notes

  before_save :consolidate_step_order

  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :citations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :notes, reject_if: :all_blank, allow_destroy: true

  friendly_id :name, use: %i[slugged scoped history], scope: [:user]

  scope :managed, -> { includes(:user) }
  scope :owned, ->(user_id) { where(user_id:) }
  scope :publicly_accessible, -> { where(publicly_accessible: true) }

  MAX_STEPS = 100
  DEFAULT_PRIMARY_PICTURE_KEY = 'site/default_food.jpg'

  # Recipes for the main/root landing page
  #
  # @return [Recipe::ActiveRecord_Relation]
  def self.root_recipes(limit: 10)
    Recipe.publicly_accessible.limit(limit)
  end

  # A basic paginated list of recipes, alphabetized by name, meant for a directory-like navigation of recipes
  #
  # @param [ActionController::Parameters<Integer>] page Current page used to fetch correct selection of recipes
  # @return [Recipe::ActiveRecord_Relation]
  def self.directory_recipes(page)
    order(:name).page(page)
  end

  # Determines if a new slug should be generated. Currently this happens when the model is first created,
  # and when the name is updated
  #
  # @return [Boolean]
  # noinspection RubyInstanceMethodNamingConvention
  def should_generate_new_friendly_id?
    new_record? || name_changed?
  end

  def consolidate_step_order
    steps.sort_by(&:order).map!.with_index do |step, idx|
      step.order = idx + 1
      step
    end
  end
end
