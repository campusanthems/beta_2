class Vote < ActiveRecord::Base
	
	scope :recent, -> { where("created_at > ?", 24.hours.ago) }
end
