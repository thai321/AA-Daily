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

FactoryGirl.define do
  factory :goal_comment do
    content "MyString"
    goal_id 1
    user_id 1
    target_id 1
  end
end
