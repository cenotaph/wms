


if Rails.env.production?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['facebook_app_id'], ENV['facebook_secret'], callback_url: 'https://booking.worldmusic.school/users/auth/facebook/callback'
    provider :twitter, ENV['twitter_consumer_key'], ENV['twitter_consumer_secret'], callback_url: 'https://booking.worldmusic.school/users/auth/twitter/callback'
    provider :google_oauth2, ENV["google_client_id"], ENV["google_client_secret"]
  end
  OmniAuth.config.full_host = 'https://booking.worldmusic.school'
else
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['facebook_app_id'], ENV['facebook_secret'], callback_url: 'http://wms.school:3000/users/auth/facebook/callback'
    provider :twitter, ENV['twitter_consumer_key'], ENV['twitter_consumer_secret'], callback_url: 'https://wms.school:3000/users/auth/twitter/callback'
    provider :google_oauth2, ENV["google_client_id"], ENV["google_client_secret"]
  end
end
