Devise.setup do |config|
  require 'omniauth-google-oauth2'
  config.omniauth :google_oauth2, 'APP_ID', 'APP_SECRET', { :scope => 'https://www.googleapis.com/auth/userinfo.email', :redirect_uri => 'http://tester.econtriver.com/auth/google_oauth2/callback', :approval_prompt => 'auto' }
  require 'omniauth-twitter'
  config.omniauth :twitter, 'APP_ID', 'APP_SECRET'
end