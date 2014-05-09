LinkedIn.configure do |config|
  config.token = ENV['OMNIAUTH_PROVIDER_KEY']
  config.secret = ENV['OMNIAUTH_PROVIDER_SECRET']
end