FactoryBot.define do
  factory :step do
    order { Faker::Number.between(from: 1, to: 100) }
    instruction { Faker::TvShows::DrWho.quote }
  end
end
