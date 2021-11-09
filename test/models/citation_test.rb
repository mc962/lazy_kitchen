# == Schema Information
#
# Table name: citations
#
#  id                   :bigint           not null, primary key
#  content_location     :string
#  content_type         :string           not null
#  last_accessed_at     :date
#  origin               :string           not null
#  publication_location :string
#  publication_title    :string
#  published_at         :date
#  publisher            :string
#  site_link            :string
#  site_title           :string
#  version              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  recipe_id            :bigint           not null
#
# Indexes
#
#  index_citations_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
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
