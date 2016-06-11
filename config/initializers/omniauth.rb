require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "b982c9a5c7374263b34900f40fc80722", "42d769517c4642e49acf53d08da0e70b", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end