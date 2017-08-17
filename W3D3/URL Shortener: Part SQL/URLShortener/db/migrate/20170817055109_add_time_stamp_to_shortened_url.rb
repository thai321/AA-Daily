class AddTimeStampToShortenedUrl < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :shortened_urls
  end
end
