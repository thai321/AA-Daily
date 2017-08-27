class Link < ApplicationRecord
  validates :title, :url, presence: true

  belongs_to :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  has_many :comments,
    class_name: 'Comment',
    foreign_key: :link_id,
    primary_key: :id
end
