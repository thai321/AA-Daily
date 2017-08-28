# == Schema Information
#
# Table name: user_comments
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  user_id    :integer          not null
#  target_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :user_comment do
    content "MyString"
    user_id 1
    target_id 1
  end
end
