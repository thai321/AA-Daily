# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :string           not null
#  commentable_type :string
#  commentable_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :commentable, polymorphic: true
end
