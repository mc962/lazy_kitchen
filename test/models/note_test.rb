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

require "test_helper"

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
