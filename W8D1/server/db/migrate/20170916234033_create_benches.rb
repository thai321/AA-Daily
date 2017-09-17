class CreateBenches < ActiveRecord::Migration[5.1]
  def change
    create_table :benches do |t|
      t.string :description
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
