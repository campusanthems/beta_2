class StaticPagesController < ApplicationController

  def home
  @genre = params[:genre]

  if params[:user_id] != nil
    @user = User.find(params[:user_id])
  else
    @user = User.new
  end

  if @genre == nil
    @top_tracks  = Track.all.sort_by{ |track| -track.votes }.take(20) 
    @top_bands = Band.all.sort_by{ |band| band.total_votes }.take(20)
  else
    @top_tracks = Track.select { |track| track.genre == @genre }.sort_by{ |track| -track.votes }.take(20)
    @top_bands = Band.select { |band| band.tracks.any? {|track| track.genre == @genre } }.sort_by{ |band| band.total_votes }.take(20)
  end
    
    if params[:track_id] != nil
      @track = Track.find(params[:track_id])
      refresh_dom_with_partial 'div#TrackPlayer', 'layouts/track_player'
    else
      @track = @top_tracks.first
    end
    
  end

  def genre_select
    redirect_to root_path(:genre => params[:genre])
  end

  def select_track
    redirect_to root_path(:track_id => params[:track_id], :genre => params[:genre])
  end

  def help
  end

  def about
  end
  
  def contant
  end
end
