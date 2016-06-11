require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "c04e750b614d43a9b8a982ecbbe6f062", "824da32005fc4624a29e46207e42e31c", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end