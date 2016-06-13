class UsersController < ApplicationController
  
  def playlist
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
  end

  def failure
    @message = params['message'] if params['message']
  end

  def tracks
    playlist = RSpotify::Playlist.find(params['user_id'],  params['id'])
    @tracks = playlist.tracks
  end

end