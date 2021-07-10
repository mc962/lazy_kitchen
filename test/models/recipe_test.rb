# == Schema Information
#
# Table name: recipes
#
#  id          :bigint           not null, primary key
#  description :text
#  image_url   :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_recipes_on_name  (name) UNIQUE
#
require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
