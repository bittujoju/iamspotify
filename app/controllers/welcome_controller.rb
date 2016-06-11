class WelcomeController < ApplicationController

  def index
  	@artists = RSpotify::Artist.search(params[:query]) if params[:query]	
  end

end