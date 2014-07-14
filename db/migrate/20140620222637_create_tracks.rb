class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
    	
    	t.integer :votes
    	t.integer :track_id
    	t.integer :band_id
		t.integer :duration
		t.integer :bpm
		t.integer :comment_count
		t.integer :playback_count

    	t.string :track_created_at
    	t.string :title
    	t.string :permalink_url
		t.string :artwork_url
		t.string :description
		t.string :genre
		t.string :release
		t.string :release_day
		t.string :release_month
		t.string :release_year
		t.string :waveform_url
		t.string :stream_url
		t.string :key_signature

		t.boolean :streamable

      t.timestamps
    end
  end
end
