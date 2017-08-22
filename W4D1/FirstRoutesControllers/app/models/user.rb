class User < ApplicationRecord
  validates :name, :email, presence: true, uniqueness: true
end
