class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
    	t.string :name
    	t.string :banner_color
    	t.string :background_color
    	
    	t.integer :total_votes


     t.timestamps
    end
  end
end
