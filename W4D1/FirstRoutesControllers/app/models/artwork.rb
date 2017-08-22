# == Schema Information
#
# Table name: artworks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artwork < ApplicationRecord
  validates :title, presence: true
  validates :image_url, presence: true, uniqueness: true
  validates :title, uniqueness: { scope: :artist_id }


  belongs_to :artist,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: :User,
    dependent: :destroy


  has_many :artwork_shares,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :ArtworkShare

  has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer


  has_many :comments,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :Comment,
    dependent: :destroy

end
