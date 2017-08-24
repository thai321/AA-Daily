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

  validates :user_name, :password_digest, presence: true
  validates :session_token, presence: true, uniqueness: true

  before_validation :ensure_session_token

  def self.find_by_credentials(user_name, password)

  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = Bcrypt::Password.create(password)
  end

  def is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  private
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

end
