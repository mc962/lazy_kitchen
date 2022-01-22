# frozen_string_literal: true
# == Schema Information
#
# Table name: authors
#
#  id          :integer          not null, primary key
#  first_name  :string           not null
#  last_name   :string
#  middle_name :string
#  citation_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_authors_on_citation_id               (citation_id)
#  index_authors_on_last_name_and_first_name  (last_name,first_name)
#

# Represents Authors in the context of Recipe Citations
class Author < ApplicationRecord
  belongs_to :citation

  validates :first_name, :citation, presence: true

  scope :managed, -> { includes(citation: [recipe: [:user]]) }
end
