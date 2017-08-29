class CreateComment < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false

      # create commentable_id:integer and its index, create commentable_type:string
      t.references :commentable, polymorphic: true, index: true

      t.timestamps
    end

  end
end
