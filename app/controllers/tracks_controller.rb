class TracksController < ApplicationController
	def vote_up
		@track = Track.find(params[:id])
		@track.vote!(request.ip)
		redirect_to root_path
	end
end