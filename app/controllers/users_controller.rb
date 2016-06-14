class UsersController < ApplicationController

  before_filter :require_user, except: [:logout,:login]
  
  def login
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    session['user_id'] = @spotify_user.id
    user = User.find_or_create_by(name: @spotify_user.id)
    user.data = @spotify_user.to_hash
    user.save!
    redirect_to user_playlists_path    
  end

  def playlists
  	  @playlists = @spotify_user.playlists
  end

  def tracks
    playlist = RSpotify::Playlist.find(@spotify_user.id,  params['id'])
    @tracks = playlist.tracks
  end

  def followers
    @followers = @spotify_user.followers
  end

  def artists
    @artists = RSpotify::Artist.search(params[:query]) if params[:query]
  end

  def follow
    @artist = RSpotify::Artist.find(params['id']) if params['id']
    # @spotify_user.follow(@artist)
    respond_to do |format|
      format.js do
        render 'follow_artist.js.erb'
      end
    end
  end

  def create_playlist
    @spotify_user.create_playlist!(params['playlist_name'])
    redirect_to user_playlists_path
  end

  def albums
    @albums = RSpotify::Album.search(params[:query]) if params[:query]
  end
  def failure
    @message = params['message'] if params['message']
  end

  def logout
    reset_session
    redirect_to welcome_path
  end

  private

  def require_user
    @spotify_user = User.refresh_user(session['user_id'])
    redirect_to user_logout_path unless @spotify_user
  end

end