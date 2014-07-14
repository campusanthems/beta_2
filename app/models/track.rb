class Track < ActiveRecord::Base
	has_many :comments
	belongs_to :band

	def vote!(ip)
  		unless Vote.recent.exists?(:ip => ip, :track_id => id)
    	increment!(:votes) 
    	band.increment!(:total_votes)
    	Vote.create(:ip => ip, :track_id => id)
    end
  end

end
