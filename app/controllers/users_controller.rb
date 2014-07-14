class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    if flash[:success] != nil
      flash[:success]
    end

    if params[:user_id] != nil
      @user = User.find(params[:user_id])
    else
      @user = User.find(params[:id])
    end

    if params[:track_id] != nil
      @track = Track.find(params[:track_id])
      refresh_dom_with_partial 'div#TrackPlayer', 'layouts/track_player'
    else 
      if @user.bands.first != nil
        @track = @user.bands.first.tracks.first
      end
    end

  end

  def refresh_content
    user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Campus Anthems!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def select_track
    user = User.find(params[:id])
    redirect_to user_path(:track_id => params[:track_id], :genre => params[:genre], :user_id => user.id)
  end

   def connect_soundcloud
    redirect_to soundcloud_client.authorize_url(:display => "popup",
    :scope => "non-expiring")
  end

  def connected_soundcloud
    if params[:error].nil?
      soundcloud_client.exchange_token(:code => params[:code])
      me = soundcloud_client.get("/me")
      current_user.update_attribute('soundcloud_username', me.username)
      current_user.update_attribute('soundcloud_user_id', me.id)
      current_user.update_attribute('soundcloud_access_token', soundcloud_client.access_token)
      current_user.update_attribute('soundcloud_refresh_token', soundcloud_client.refresh_token)
      current_user.update_attribute('soundcloud_expires_at', soundcloud_client.expires_at)
      
      

      band = Band.create!(user_id: current_user.id, 
        band_id: me.id, 
        track_count: me.track_count, 
        username: me.username,
        permalink_url: me.permalink_url,
        avatar_url: me.avatar_url,
        country: me.country,
        full_name: me.full_name,
        city: me.city,
        website: me.website,
        website_title: me.website_title,
        description: me.description)

      tracks = soundcloud_client.get("/users/#{me.id}/tracks")
      tracks.each do |track|
        Track.create!(
          votes: 0,
          track_id: track.id,
          band_id: band.id,
          duration: track.duration,
          bpm: track.bpm,
          comment_count: track.comment_count,
          playback_count: track.playback_count,
          track_created_at: track.created_at,
          title: track.title,
          permalink_url: track.permalink_url,
          artwork_url: track.artwork_url,
          description: track.description,
          genre: track.genre,
          release: track.release,
          release_day: track.release_day,
          release_month: track.release_month,
          release_year: track.release_year,
          waveform_url: track.waveform_url,
          stream_url: track.stream_url,
          key_signature: track.key_signature,
          streamable: track.streamable)
      end
    end
    redirect_to current_user
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :school_id)
  end

  def soundcloud_client 
    return @soundcloud_client if @soundcloud_client
      @soundcloud_client = User.soundcloud_client
    end

  # Before filters
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
