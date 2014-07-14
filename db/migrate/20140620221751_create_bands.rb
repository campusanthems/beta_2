class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|

    	t.integer :user_id
    	t.integer :band_id
    	t.integer :track_count
        t.integer :total_votes

    	t.string :username
    	t.string :permalink_url
    	t.string :avatar_url
    	t.string :country
    	t.string :full_name
    	t.string :city
    	t.string :website
    	t.string :website_title

    	t.string :band_members
    	t.string :class_years
        t.string :description

      t.timestamps
    end
  end
end
