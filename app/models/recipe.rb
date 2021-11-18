# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id                  :bigint           not null, primary key
#  description         :text
#  image_url           :string
#  name                :string           not null
#  publicly_accessible :boolean          default(FALSE), not null
#  slug                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_recipes_on_name_and_user_id  (name,user_id) UNIQUE
#  index_recipes_on_slug              (slug) UNIQUE
#  index_recipes_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# Holds all information relating to an overall recipe itself
class Recipe < ApplicationRecord
  extend FriendlyId

  has_many :steps, lambda {
    # Recipe's steps should be displayed in order
    order(order: :asc)
  }, dependent: :destroy
  has_many :ingredients, through: :steps
  has_many :citations
  belongs_to :user


  validates :name, presence: true
  validates :name, uniqueness: {
    scope: [:user_id]
  }

  accepts_nested_attributes_for(:steps, :citations)

  friendly_id :name, use: [:slugged, :scoped, :history], scope: [:user]

  scope :managed, -> { includes(:user) }
  scope :publicly_accessible, -> { where(publicly_accessible: true) }

  MAX_STEPS = 100

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
  #noinspection RubyInstanceMethodNamingConvention
  def should_generate_new_friendly_id?
    new_record? || name_changed?
  end
end
