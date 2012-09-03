Gem::Specification.new do |s|
  s.name         = 'frame'
  s.version      = '0.0.3'
  s.date         = '2012-09-02'
  s.summary      = "Frame will setup various Ruby on Rails projects with an instantly usable application."
  s.description  = "Frame will setup various Ruby on Rails projects with an instantly usable application. The user can choose if they want authentication with devise, omniauth, and uses active_admin."
  s.authors      = ["Nik Cimino"]
  s.email        = ["nik@econtriver.com"]
  s.homepage     = "https://github.com/ncimino/frame"
  s.files        = Dir["{lib,test}/**/*", "[A-Z]*"]
  s.require_path = "lib"
  s.rubyforge_project = s.name

  #s.add_development_dependency 'rspec-rails', '~> 2.0.1'
  #s.add_development_dependency 'cucumber', '~> 0.9.2'
  #s.add_development_dependency 'rails', '~> 3.0.0'
  #s.add_development_dependency 'mocha', '~> 0.9.8'
  #s.add_development_dependency 'bcrypt-ruby', '~> 2.1.2'

  s.required_rubygems_version = ">= 1.3.4"
end
