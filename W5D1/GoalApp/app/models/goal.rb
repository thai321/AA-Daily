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

class Goal < ApplicationRecord
  include Commentable

  validates :title, :user, :description, presence: true

  belongs_to :user

  has_many :goal_comments,
    primary_key: :id,
    foreign_key: :goal_id,
    class_name: :GoalComment
end
