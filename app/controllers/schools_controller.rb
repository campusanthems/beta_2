class SchoolsController < ApplicationController
	def index

	end

	def show
		if params[:school_id] != nil
			@school = School.find(params[:school_id])
		else
			@school = School.find(params[:id])
		end
		@genre = params[:genre]

		
		  if @genre == nil
			@top_tracks = Track.select {|track| track.band.user.school.name == @school.name}.sort_by{ |track| -track.votes }.take(20) 
			@top_bands = Band.select {|band| band.user.school.name == @school.name}.sort_by{ |band| band.total_votes }.take(20)
		else
			@top_tracks = Track.select {|track| track.band.user.school.name == @school.name}.select { |track| track.genre == @genre }.sort_by{ |track| -track.votes }.take(20)
			@top_bands = Band.select {|band| band.user.school.name == @school.name}.select { |band| band.tracks.any? {|track| track.genre == @genre } }.sort_by{ |band| band.total_votes }.take(20)
		end 

		if params[:track_id] != nil
	      @track = Track.find(params[:track_id])
	      refresh_dom_with_partial 'div#TrackPlayer', 'layouts/track_player'
	    else
	      @track = @top_tracks.first
	    end
	end

	def genre_select
		school = School.find(params[:school_id])
   		redirect_to school_path(:genre => params[:genre], :school_id => school.id)
  	end

  	def select_track
	  school = School.find(params[:school_id])
	  redirect_to band_path(:track_id => params[:track_id], :genre => params[:genre], :user_id => nil, :band_id => nil, :school_id => params[:school_id])
	end

end
