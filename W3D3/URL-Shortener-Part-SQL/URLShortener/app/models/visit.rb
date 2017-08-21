# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  shortened_url_id :integer
#

class Visit < ApplicationRecord
  validates :user_id, :shortened_url_id, presence: true

  belongs_to :visitors,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :urls,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :ShortenedUrl

  def self.record_visit!(user_id, shortened_url_id)
    Visit.create!(user_id: user_id, shortened_url_id: shortened_url_id)
  end

end
