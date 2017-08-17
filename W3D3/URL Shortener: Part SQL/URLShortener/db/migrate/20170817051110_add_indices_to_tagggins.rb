class AddIndicesToTagggins < ActiveRecord::Migration[5.1]
  def change
    add_index :taggings, :topic_id
    add_index :taggings, :url_id
  end
end
