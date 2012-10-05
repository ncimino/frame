require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class OmniauthGenerator < Base
    include Rails::Generators::Migration

    desc "Installs Omniauth."

    def install_omniauth

      gem 'omniauth'
      gem 'omniauth-twitter'
      gem 'omniauth-google-oauth2'
      gem 'omniauth-github'

      Bundler.with_clean_env do
        run "bundle"
      end
    end

    def direct_devise_to_registrations
      add_if_missing('config/routes.rb', ", :controllers => {:registrations => 'registrations'}", :after => "devise_for :users")
    end

    def generate_authentication_model
      generate("model authentication user_id:integer provider:string uid:string")
      add_if_missing('app/models/authentication.rb', "
  belongs_to :user

  def provider_name
    if provider == 'open_id'
      'OpenID'
    elsif provider == 'google_oauth2'
      'Google'
    else
      provider.titleize
    end
  end\n", :after => "class Authentication < ActiveRecord::Base\n")
    end

    # Leave the routes?
    def generate_authentication_controller
      generate('controller Authentications index create destroy')
      template('app/controllers/authentications_controller.rb')
      remove_file('app/views/authentications/index.html.erb')
      remove_file('app/views/authentications/create.html.erb')
      remove_file('app/views/authentications/destroy.html.erb')
      # Need this index?
      template('app/views/authentications/index.html.erb')
    end

    def generate_registration_controller
      generate('controller Registrations edit new')
      template('app/views/registrations/edit.html.erb')
      template('app/views/registrations/new.html.erb')
      template('app/controllers/registrations_controller.rb')
    end

    def add_routes
      add_if_missing('config/routes.rb', "
  match '/auth/failure' => 'authentications#failure'
  match '/auth/:provider/callback' => 'authentications#create'
  ", :after => "get \"authentications/destroy\"\n")
    end

    def add_username_to_user
      generate("migration AddUsernameToUser username:string")
    end

    def update_user_model
      template('app/models/user.rb')
    end

    def copy_images
      template('app/assets/images/facebook_32.png')
      template('app/assets/images/github_32.png')
      template('app/assets/images/google_32.png')
      template('app/assets/images/twitter_32.png')
      template('app/assets/images/facebook_64.png')
      template('app/assets/images/github_64.png')
      template('app/assets/images/google_64.png')
      template('app/assets/images/twitter_64.png')
    end

    def add_sign_in_to_devise
      template('app/views/devise/sessions/new.html.erb')
      template('app/views/shared/_open_auth.html.erb')
      template('app/views/shared/_login_form.html.erb')
    end

    def update_db
      if yes?("Would you like to migrate the database?")
        rake("db:migrate")
      end
    end

    end
  end
end 
