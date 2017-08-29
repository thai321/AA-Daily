# == Schema Information
#
# Table name: goal_comments
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  goal_id    :integer          not null
#  user_id    :integer          not null
#  target_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GoalComment < ApplicationRecord
  validates :content, presence: true

  belongs_to :goal
end
