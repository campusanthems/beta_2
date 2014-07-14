class Band < ActiveRecord::Base
	has_many :comments
	has_many :tracks
	#has_many :band_members
	
	belongs_to :user
end
