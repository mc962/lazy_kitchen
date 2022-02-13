# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  approved               :boolean          default(FALSE), not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    username { Faker::Internet.unique.username }
    password { 'password' }
    # Default users to be confirmed so that tests may be performed using them
    confirmed_at { DateTime.now }
    # Default users to be approved so that tests may be performed using them
    approved { true }

    factory :user_with_full_recipes do
      transient do
        recipes_count { 5 }
      end

      after(:create) do |user, evaluator|
        FactoryBot.create_list(:recipe_with_full_steps, evaluator.recipes_count, user: user)

        user.reload
      end
    end
    factory :user_with_recipes do
      transient do
        recipes_count { 5 }
      end

      after(:create) do |user, evaluator|
        FactoryBot.create_list(:recipe_with_steps, evaluator.recipes_count, user: user)

        user.reload
      end
    end
  end
end
