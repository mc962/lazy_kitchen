# == Schema Information
#
# Table name: recipes
#
#  id                  :bigint           not null, primary key
#  description         :text
#  image_url           :string
#  name                :string           not null
#  publicly_accessible :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_recipes_on_name     (name) UNIQUE
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recipe < ApplicationRecord
  # Holds all information relating to an overall recipe itself

  has_many :steps, -> {
    # Recipe's steps should be displayed in order
    order(order: :asc)
  }, dependent: :destroy
  has_many :ingredients, through: :steps
  has_many :citations
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: true

  accepts_nested_attributes_for *[:steps, :citations]

  MAX_STEPS = 100

  # Only query for publicly accessible recipes by default, to prevent inadvertently displaying private recipes publicly
  #
  # @return [ActiveRecord::Relation<Recipe>]
  def self.default_scope
    where(:publicly_accessible => true)
  end

  # Recipes for the main/root landing page
  #
  # @return [Recipe::ActiveRecord_Relation]
  def self.root_recipes(limit: 10)
    Recipe.limit(limit)
  end
end
