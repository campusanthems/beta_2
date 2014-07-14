class BandsController < ApplicationController

def show
  if params[:band_id] != nil
    @band = Band.find(params[:band_id])
  else
	 @band = Band.find(params[:id])
  end
	
  if params[:track_id] != nil
      @track = Track.find(params[:track_id])
      refresh_dom_with_partial 'div#TrackPlayer', 'layouts/track_player'
  else
      @track = @band.tracks.first
  end

  @tracks = @band.tracks
end

def update
  @band = Band.find(params[:id])
  user = @band.user

  if @band.update_attributes(band_params)

    flash[:success] = "Band Updated"
    redirect_to @band.user

  else
  
    flash[:notice] = "Band Was Not Updated"
    redirect_to @band.user

  end
end

def select_track
  band = Band.find(params[:id])
  redirect_to band_path(:track_id => params[:track_id], :genre => nil, :user_id => nil, :band_id => band.id)
end

private

def band_params
    params.require(:band).permit(:band_members, :class_years, :description)
  end

end
