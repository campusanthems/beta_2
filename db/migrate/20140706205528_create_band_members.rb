class CreateBandMembers < ActiveRecord::Migration
  def change
    create_table :band_members do |t|
    	t.string :band_id
    	t.string :name
    	t.string :year

      t.timestamps
    end
  end
end
