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

FactoryBot.define do
  factory :author do
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }

    association :citation
  end
end
