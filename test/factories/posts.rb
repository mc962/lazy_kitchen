# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  modified_at  :date
#  published    :boolean          not null
#  published_at :date
#  slug         :string
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_posts_on_slug     (slug) UNIQUE
#  index_posts_on_title    (title) UNIQUE
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :post do
    title { Faker::Book.unique.title }
    published_at { Faker::Date.backward(7) }
    modified_at { Faker::Date.backward(2) }
    published { false }

    association :user
  end
end
