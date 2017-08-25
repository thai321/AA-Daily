# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  before_validation :ensure_session_token

  attr_reader :password

  has_many :cats
  has_many :rental_requests,
    foreign_key: :user_id,
    class_name: :CatRentalRequest

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil if !user # checks if user exists
    user.is_password?(password) ? user : nil # checks if password is valid
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

  def self.generate_session_token
    SecureRandom.base64(16)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
