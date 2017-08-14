class CreateHouseTable < ActiveRecord::Migration[5.1]
  def change
    create_table :houses do |t|
      t.string :address, null: false
      t.timestamps
    end
  end
end
