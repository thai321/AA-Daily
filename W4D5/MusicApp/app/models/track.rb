# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  title      :string           not null
#  ord        :integer          not null
#  lyrics     :text             not null
#  bonus      :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord
  validates :title, :album, :ord, presence: true
  validates :ord, :title, uniqueness: { scope: :album_id }
  validates :bonus, inclusion: [true, false]

  belongs_to :album

  has_one :band, through: :album, source: :band
end
