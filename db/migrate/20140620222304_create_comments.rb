class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :parent_id
    	t.integer :comment_id
    	
    	t.string :create_at
    	t.string :body

      t.timestamps
    end
  end
end
