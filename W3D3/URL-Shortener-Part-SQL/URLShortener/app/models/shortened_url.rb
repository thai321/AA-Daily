# == Schema Information
#
# Table name: shortened_urls
#
#  id        :integer          not null, primary key
#  long_url  :string           not null
#  short_url :string
#  user_id   :integer          not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true
  validate :nonpremium_max, :no_spamming

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :visitors

  has_many :visitors_uniques,
    Proc.new { distinct }, #<<<
    through: :visits,
    source: :visitors

  has_many :taggings,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Tagging

  has_many :topics,
    through: :taggings,
    source: :tag_topic


  def self.random_code
    code_url = SecureRandom.urlsafe_base64

    until !ShortenedUrl.exists?(short_url: code_url)
      code_url = SecureRandom.urlsafe_base64
    end

    code_url
  end

  def self.create_url(user, long_url)
    ShortenedUrl.create(
      user_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code)
  end

  def num_clicks
    visitors.count
  end

  def num_uniques
    visitors_uniques.count
  end

  def num_recent_uniques
    visits
      .select(:user_id)
      .distinct.where('visits.created_at <= ? ', 10.minutes.ago)
      .count
  end

  def no_spamming
    num_urls = ShortenedUrl
      .where('created_at >= ?', 1.minute.ago)
      .where('user_id = ?', self.user_id)
      .length

    errors[:spamming] << "No more than 5 urls per minute" if num_urls > 5
  end

  def nonpremium_max
    if !User.find(self.user_id).permium
      num_urls = ShortenedUrl
        .where(user_id: self.user_id)
        .length

      if num_urls > 5
        errors[:NonPremium] << "Only Permium member can create more than 5 urls"
      end
    end
  end

end
