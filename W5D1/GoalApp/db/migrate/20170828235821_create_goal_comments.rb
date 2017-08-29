class CreateGoalComments < ActiveRecord::Migration[5.1]
  def change
    create_table :goal_comments do |t|
      t.string :content, null: false
      t.integer :goal_id, null: false
      t.integer :user_id, null: false
      t.integer :target_id, null: false

      t.timestamps
    end

  end
end
