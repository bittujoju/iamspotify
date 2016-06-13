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
    playlist = RSpotify::Playlist.find(params['user_id'],  params['id'])
    @tracks = playlist.tracks
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