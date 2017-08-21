class AddColumnsToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :user_id, :integer
    add_column :visits, :shortened_url_id, :integer
  end
end
