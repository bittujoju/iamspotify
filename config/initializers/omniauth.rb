require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "b982c9a5c7374263b34900f40fc80722", "c1c87b6e1a4a4563b7bcd35e6b37e942", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end