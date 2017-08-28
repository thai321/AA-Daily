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

class UserComment < ApplicationRecord
  validates :user, :target, :content, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :target,
    primary_key: :id,
    foreign_key: :target_id,
    class_name: :User

end
