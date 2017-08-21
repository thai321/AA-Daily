# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ApplicationRecord
  validates :topic, presence: true, uniqueness: true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :Tagging

  has_many :urls,
    through: :taggings,
    source: :url

  def popular_links
    urls.joins(:visits)
      .select('long_url, COUNT(visits.id) as visits',)
      .group(:long_url)
      .order('COUNT(visits.id) DESC')
      .limit(2)
  end
end
