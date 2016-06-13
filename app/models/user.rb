class User < ActiveRecord::Base
  
  def self.refresh_user(user_id)
    user = User.find_by(name: user_id)
    spotify_user =  RSpotify::User.new(user.data) if user
    spotify_user
  end

  serialize :data,Hash
end