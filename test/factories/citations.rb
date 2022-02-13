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

FactoryBot.define do
  factory :citation do
    content_location { Faker::Number.between(from: 1, to: 800).to_s }
    content_type { Citation::CONTENT_TYPES.to_a.sample }
    last_accessed_at { Faker::Date.backward } # TODO ensure that last_accessed_at > published_at
    origin { Citation::ORIGINS.to_a.sample }
    publication_location { Faker::TvShows::GameOfThrones.city }
    publication_title { Faker::Book.title }
    published_at { Faker::Date.backward }
    publisher { Faker::Book.publisher }
    site_link { Faker::Internet.url }
    site_title { Faker::Book.title }
    version { Faker::Number.between(from: 1, to: 20).to_s }

    recipe { association :recipe_with_user }

    factory :citation_with_authors do
      transient do
        authors_count { 5 }
      end

      after(:create) do |citation, evaluator|
        FactoryBot.create_list(:author, evaluator.authors_count, citation: citation)

        citation.reload
      end
    end
  end
end
