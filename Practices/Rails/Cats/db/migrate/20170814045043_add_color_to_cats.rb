class AddColorToCats < ActiveRecord::Migration[5.1]
  def change
    add_column :cats, :color, :string
  end
end
