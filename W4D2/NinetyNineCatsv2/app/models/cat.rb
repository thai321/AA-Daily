# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  COLORS = ["White", "Green", "Red", "Orange", "Brown", "Yellow", "Blue"].freeze
  validates :sex, inclusion: ["M", "F"]
  validates :color, inclusion: COLORS
  validates :birth_date, :color, :name, :sex, :description, presence: true

  # has_many :rental_requests, dependent: :destroy

  def age
    today = Date.today
    ((today - self[:birth_date]) / 365).to_i
  end

end
