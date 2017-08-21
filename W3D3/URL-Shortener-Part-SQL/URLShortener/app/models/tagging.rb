# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  topic_id   :integer
#  url_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tagging < ApplicationRecord

  belongs_to :tag_topic,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :TagTopic

  belongs_to :url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl

end
