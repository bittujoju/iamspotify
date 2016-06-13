class UsersController < ApplicationController
  
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @playlists = spotify_user.playlists
  end

  def failure
    @message = params['message'] if params['message']
  end

  def sign_in
  end
  

end