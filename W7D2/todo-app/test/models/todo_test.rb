# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  body       :string           not null
#  done       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
