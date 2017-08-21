class RemoveUrlFromVisits < ActiveRecord::Migration[5.1]
  def change
    remove_column :visits, :user_id, :integer
    remove_column :visits, :shortened_url_id, :integer
  end
end
