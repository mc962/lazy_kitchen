# == Schema Information
#
# Table name: recipes
#
#  id                  :bigint           not null, primary key
#  description         :text
#  image_url           :string
#  name                :string           not null
#  publicly_accessible :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_recipes_on_name     (name) UNIQUE
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
