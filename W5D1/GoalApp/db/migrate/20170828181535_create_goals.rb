class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.integer :user_id, null: false
      t.boolean :private, null: false, default: false
      t.boolean :completed, null: false, default: false
      t.string :description, null: false

      t.timestamps
    end

    add_index :goals, :title
    add_index :goals, :user_id
  end
end
