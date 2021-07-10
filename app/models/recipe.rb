# == Schema Information
#
# Table name: recipes
#
#  id          :bigint           not null, primary key
#  description :text
#  image_url   :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_recipes_on_name  (name) UNIQUE
#
class Recipe < ApplicationRecord
  has_many :steps, -> {
    # Recipe's steps should be displayed in order
    order(order: :asc)
  }, dependent: :destroy
  has_many :ingredients, through: :steps

  validates :name, presence: true
  validates :name, uniqueness: true

  accepts_nested_attributes_for :steps
end
