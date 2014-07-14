class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.string :soundcloud_username
      t.string :soundcloud_access_token
      t.string :soundcloud_refresh_token
      t.string :hometown
      
      t.boolean :admin, default:false

      t.integer :soundcloud_user_id
      t.integer :school_id

      t.datetime  :soundcloud_expires_at

      t.timestamps
    end
    add_index :users, :email, unique: true
  	add_index :users, :remember_token 
  	end
end
