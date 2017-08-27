class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.integer :user_id, null: false
      t.integer :track_id, null: false
      t.string :content, null: false

      t.timestamps
    end

    add_index :notes, :user_id
    add_index :notes, :track_id
  end
end
