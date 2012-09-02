require 'test/unit'

# Must set before requiring generator libs.
TMP_ROOT = File.dirname(__FILE__) + "/tmp" unless defined?(TMP_ROOT)
PROJECT_NAME = "myproject" unless defined?(PROJECT_NAME)
app_root = File.join(TMP_ROOT, PROJECT_NAME)
if defined?(APP_ROOT)
  APP_ROOT.replace(app_root)
else
  APP_ROOT = app_root
end
if defined?(RAILS_ROOT)
  RAILS_ROOT.replace(app_root)
else
  RAILS_ROOT = app_root
end

require 'rubygems'
gem 'rails', '2.0.2' # getting a Rails.configuration error with 2.1
gem 'rubigen', '1.4'
gem 'shoulda', '2.0.6'
require 'rubigen' # gem install rubigen --version=1.4
require 'rubigen/helpers/generator_test_helper'
require 'rails_generator'
require 'shoulda' # gem install shoulda --version=2.0.6
require 'mocha'