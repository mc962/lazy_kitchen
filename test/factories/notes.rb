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

FactoryBot.define do
  factory :note do
    content { Faker::Movies::StarWars.quote }

    transient do
      notable { nil }
    end

    notable_id { notable.id }
    notable_type { notable.class.name }
  end
end
