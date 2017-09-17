# == Schema Information
#
# Table name: benches
#
#  id          :integer          not null, primary key
#  description :string
#  lat         :float
#  lng         :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Bench < ApplicationRecord
  validates :description, :lat, :lng, presence: true

  def self.in_bounds(bounds)
    self.where('lat > ?', bounds[:southWest][:lat])
      .where('lat < ?', bounds[:northEast][:lat])
      .where('lng > ?', bounds[:southWest][:lng])
      .where('lng < ?', bounds[:northEast][:lng])
  end
end
