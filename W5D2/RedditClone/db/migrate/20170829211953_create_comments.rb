class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :parent_id

      t.timestamps
    end

    add_index :comments, :content
    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end
