class CreateCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :create_users do |t|
      t.string :user_name, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false

      t.timestamps
    end

  end
end
