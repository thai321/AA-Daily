# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  year       :integer          not null
#  title      :string           not null
#  live       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord

  validates :title, :band, :year, presence: true
  validates :live, inclusion: [true, false]
  validates :title, uniqueness: { scope: :band_id }

  after_initialize :set_live_default

  belongs_to :band

  has_many :tracks, dependent: :destroy

  private
  def set_live_default
    self.live ||= false
  end
end
