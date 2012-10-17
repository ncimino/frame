Gem::Specification.new do |s|
  s.name         = 'frame'
  s.version      = '0.1.1'
  s.date         = '2012-10-16'
  s.summary      = "Frame will setup various Ruby on Rails projects with an instantly usable application."
  s.description  = "Frame will setup various Ruby on Rails projects with an instantly usable application. The user can choose if they want authentication with devise, omniauth, and uses active_admin."
  s.authors      = ["Nik Cimino"]
  s.email        = ["nik@econtriver.com"]
  s.homepage     = "https://github.com/ncimino/frame"
  s.files        = Dir["{lib,test}/**/*", "[A-Z]*"]
  s.require_path = "lib"
  s.rubyforge_project = s.name

  #s.required_rubygems_version = ">= 1.9.3"

  s.add_development_dependency 'activeadmin'
  s.add_development_dependency 'coffee-rails', '~> 3.2.1'
  s.add_development_dependency 'cucumber-rails'
  s.add_development_dependency 'devise'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'meta_search'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'oauth2'
  s.add_development_dependency 'omniauth'
  s.add_development_dependency 'omniauth-google-oauth2'
  s.add_development_dependency 'omniauth-twitter'
  s.add_development_dependency 'omniauth-github'
  s.add_development_dependency 'omniauth-facebook'
  s.add_development_dependency 'rails', '= 3.2.8'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sass-rails', '~> 3.2.3'
  s.add_development_dependency 'uglifier', '>= 1.0.3'
end
