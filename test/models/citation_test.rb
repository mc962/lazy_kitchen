# == Schema Information
#
# Table name: citations
#
#  id                      :bigint           not null, primary key
#  additional_contributors :string           is an Array
#  content_location        :string
#  content_type            :string           not null
#  last_accessed_at        :date
#  origin                  :string           not null
#  publication_location    :string
#  publication_title       :string
#  published_at            :date
#  publisher               :string
#  site_link               :string
#  site_title              :string
#  version                 :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  recipe_id               :bigint           not null
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
  # test "the truth" do
  #   assert true
  # end
end
