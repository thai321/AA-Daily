# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  user_id     :integer          not null
#  private     :boolean          default(FALSE), not null
#  completed   :boolean          default(FALSE), not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    title "MyString"
    user_id 1
    private false
    completed false
  end
end
