# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit

  has_many :visited_urls,
    through: :visits,
    source: :urls


  has_many :visited_urls_uniques,
    Proc.new { distinct }, #<<<
    through: :visits,
    source: :urls

    def visitor_clicks
      visited_urls.count
    end

    def visitor_clicks_uniques
      visited_urls_uniques.count
    end

    def num_recent_uniques
      visits
        .select(:shortened_url_id)
        .distinct.where('visits.created_at >= ? ', 10.minutes.ago)
        .count
    end

end
