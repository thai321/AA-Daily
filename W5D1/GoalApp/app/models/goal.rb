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
  validates :title, :user, :description, presence: true

  belongs_to :user
end
