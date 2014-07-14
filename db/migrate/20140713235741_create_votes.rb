class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.integer :track_id
    	t.string :ip

    	t.timestamps
    end
    add_index :votes, :track_id
    add_index :votes, :ip
  end
end
