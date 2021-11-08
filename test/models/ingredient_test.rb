# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_ingredients_on_name     (name) UNIQUE
#  index_ingredients_on_slug     (slug) UNIQUE
#  index_ingredients_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
