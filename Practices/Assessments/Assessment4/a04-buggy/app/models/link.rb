class Link < ApplicationRecord
  validates :title, :url, presence: true

  belongs_to :user,
    class_name: 'user',
    foreign_key: :user_id,
    primary_key: :id

  has_many :comments,
    class_name: 'Comment',
    primary_key: :link_id,
    foreign_key: :id
end
