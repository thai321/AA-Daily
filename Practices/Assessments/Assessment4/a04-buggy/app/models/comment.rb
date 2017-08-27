class Comment < ApplicationRecord
  validate :body, presence: true

  belongs_to :user
  has_one :link
end
