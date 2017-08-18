class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :answer_choice_id
    end

    add_index :responses, :user_id
    add_index :responses, :answer_choice_id
  end
end
