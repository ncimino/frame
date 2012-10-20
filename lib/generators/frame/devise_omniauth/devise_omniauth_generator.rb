require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class DeviseOmniauthGenerator < Base
    include Rails::Generators::Migration

    desc "Installs Devise and makes it Omniauthable."

    def install_devise
      gem("rspec-rails", :group => "test, development")
      gem("cucumber-rails", :group => "test, development")
      gem("devise")
      gem("omniauth-twitter")
      gem("omniauth-facebook")
      gem("omniauth-github")
      gem("omniauth-google-oauth2")
      Bundler.with_clean_env do
        run "bundle"
      end
      generate("devise:install")
      generate("devise", "User")
      generate("devise:views")
    end

    def add_callback_controller
      template('app/controllers/omniauth_callbacks_controller.rb')
    end

    def make_omniauthable
      template('app/models/user.rb')
    end

    def add_do_routes
      template('config/routes.rb')
    end

    def add_omni_services
      add_if_missing('config/initializers/devise.rb', "\n  config.omniauth :twitter, 'APP_ID', 'APP_SECRET'", :after => "# config.omniauth :github, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'")
      add_if_missing('config/initializers/devise.rb', "\n  config.omniauth :google_oauth2, 'APP_ID', 'APP_SECRET'", :after => "# config.omniauth :github, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'")
      add_if_missing('config/initializers/devise.rb', "\n  config.omniauth :facebook, 'APP_ID', 'APP_SECRET'", :after => "# config.omniauth :github, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'")
      uncomment_lines('config/initializers/devise.rb', "config.omniauth :github, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'")
    end

    def add_default_layout
      template('app/views/layouts/defaults.html.erb')
    end

    def update_initializers
      gsub_file 'config/initializers/devise.rb', /config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"/ do
        "config.mailer_sender = \"webmaster@econtriver.com\""
      end
    end

    def update_environments
      application(nil, :env => "production") do "
  config.action_mailer.default_url_options = { :host => \"econtriver.com\" }
  config.action_mailer.smtp_settings = { :openssl_verify_mode  => 'none' }"
      end
      application(nil, :env => "test") do
        "config.action_mailer.default_url_options = { :host => 'localhost:3000' }"
      end
      application(nil, :env => "development") do
        "config.action_mailer.default_url_options = { :host => 'localhost:3000' }"
      end
    end

    def replace_email_username
      template("app/views/devise/sessions/new.html.erb")
      template("app/views/devise/registrations/new.html.erb")
      template("app/views/devise/registrations/edit.html.erb")
    end

    def add_omniauth_to_users
      generate("migration AddOmniauthToUsers provider:string uid:string")
    end

    def add_username_to_users
      generate("migration AddUsernameToUsers username:string")
    end

    def update_db
      rake("db:migrate")
    end

    end
  end
end 
