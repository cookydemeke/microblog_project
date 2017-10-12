# ======= db/migrate/20171010150852_create_users_table.rb =======

class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :password
      t.string :usertype
      t.string :email
      t.datetime :created_at
    end
  end
end
