class UsersController < ApplicationController
  
  def login
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    session['user_id'] = @spotify_user.id
    user = User.find_or_create_by(name: @spotify_user.id)
    user.data = @spotify_user.to_hash
    user.save!
    redirect_to user_playlists_path    
  end

  def playlists
  	spotify_user = User.refresh_user(session['user_id']) if session['user_id']
  	if spotify_user
  	  @playlists = spotify_user.playlists
  	else 
  	  redirect_to user_login_path
  	end
  end

  def failure
    @message = params['message'] if params['message']
  end

  def tracks
    playlist = RSpotify::Playlist.find(params['user_id'],  params['id'])
    @tracks = playlist.tracks
  end

  def logout
    reset_session
    redirect_to welcome_path
  end

end