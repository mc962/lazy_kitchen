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
#
# Indexes
#
#  index_recipes_on_name  (name) UNIQUE
#
class Recipe < ApplicationRecord
  # Holds all information relating to an overall recipe itself

  has_many :steps, -> {
    # Recipe's steps should be displayed in order
    order(order: :asc)
  }, dependent: :destroy
  has_many :ingredients, through: :steps
  has_many :citations

  validates :name, presence: true
  validates :name, uniqueness: true

  accepts_nested_attributes_for *[:steps, :citations]

  MAX_STEPS = 100
end
