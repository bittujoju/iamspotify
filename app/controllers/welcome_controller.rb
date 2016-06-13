class WelcomeController < ApplicationController

  def index
  	@artists = RSpotify::Artist.search(params[:query]) if params[:query]
  	redirect_to user_playlists_path if session['user_id']
  end

end