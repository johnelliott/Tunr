class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.boolean :admin, default: false, null: false
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :remember_token #makes it really fast to look up users with remember_token and email
  end
end
