class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      # 암호화
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
