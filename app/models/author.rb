# frozen_string_literal: true

# == Schema Information
#
# Table name: authors
#
#  id          :bigint           not null, primary key
#  first_name  :string           not null
#  last_name   :string
#  middle_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  citation_id :bigint           not null
#
# Indexes
#
#  index_authors_on_citation_id               (citation_id)
#  index_authors_on_last_name_and_first_name  (last_name,first_name)
#
# Foreign Keys
#
#  fk_rails_...  (citation_id => citations.id)
#

# Represents Authors in the context of Recipe Citations
class Author < ApplicationRecord
  belongs_to :citation

  validates :first_name, :citation, presence: true

  scope :managed, -> { includes(citation: [recipe: [:user]]) }
end
