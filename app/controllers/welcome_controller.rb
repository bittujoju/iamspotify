class WelcomeController < ApplicationController

  def index
  	@tracks = RSpotify::Track.search(params[:query]) if params[:query]
  	redirect_to user_playlists_path if session['user_id']
  end

end