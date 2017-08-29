# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  user_id    :integer          not null
#  post_id    :integer          not null
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  validates :content, :author, :post, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User,
    inverse_of: :comments

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Post,
    inverse_of: :comments

  belongs_to :parent_comment,
    primary_key: :id,
    foreign_key: :parent_id,
    class_name: :Comment,
    optional: true


end
