#require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  #require 'omniauth-google-oauth2'
  provider :google_oauth2, 'APP_ID', 'APP_SECRET', { :scope => 'https://www.googleapis.com/auth/userinfo.email', :redirect_uri => 'http://econtriver.com/auth/google_oauth2/callback', :approval_prompt => 'auto' }

  #require 'omniauth-twitter'
  provider :twitter, 'APP_ID', 'APP_SECRET'

  #require 'omniauth-github'
  provider :github, 'APP_ID', 'APP_SECRET'

  #require 'omniauth-facebook'
  provider :facebook, 'APP_ID', 'APP_SECRET'

  #provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end