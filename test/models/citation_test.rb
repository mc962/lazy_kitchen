# == Schema Information
#
# Table name: citations
#
#  id                   :integer          not null, primary key
#  origin               :string           not null
#  content_type         :string           not null
#  publication_title    :string
#  publication_location :string
#  publisher            :string
#  published_at         :date
#  content_location     :string
#  version              :string
#  site_title           :string
#  last_accessed_at     :date
#  site_link            :string
#  recipe_id            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_citations_on_recipe_id  (recipe_id)
#

require "test_helper"

class CitationTest < ActiveSupport::TestCase
  subject { FactoryBot.create(:citation) }

  context 'associations' do
    should belong_to(:recipe)
    should have_many(:authors)

    context 'nested models' do
      should accept_nested_attributes_for(:authors)
    end
  end

  context 'validations' do
    should validate_presence_of(:recipe)
    should validate_inclusion_of(:content_type).in_array(Citation::CONTENT_TYPES)
    should validate_inclusion_of(:origin).in_array(Citation::ORIGINS)
  end
end
