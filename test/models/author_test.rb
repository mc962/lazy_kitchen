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

require "test_helper"

class AuthorTest < ActiveSupport::TestCase
  subject { FactoryBot.create(:author) }

  context 'associations' do
    should belong_to(:citation)
  end

  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:citation)
  end
end
