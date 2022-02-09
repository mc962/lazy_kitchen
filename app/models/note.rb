# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  content      :text             not null
#  notable_type :string           not null
#  notable_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_notes_on_notable  (notable_type,notable_id)
#

# Represents a simple extra note on a top-level resource (i.e. Recipe, Ingredient, etc.)
class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true

  validates :content, :notable, presence: true

  def recipe
    Recipe.joins('JOIN notes ON recipes.id = notes.notable_id').where(recipes: { id: notable_id })
  end
end
