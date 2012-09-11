require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class DeviseGenerator < Base
    include Rails::Generators::Migration

    desc "Installs Devise."

    def install_devise
      gem("rspec-rails", :group => "test")
      gem("cucumber-rails", :group => "test")

      if yes?("Would you like to install Devise?")
        gem("devise")
        generate("devise:install")
        default_model = "user"
        model_name = ask("What would you like the user model to be called? [#{default_model}]")
        model_name = default_model if model_name.blank?
        generate("devise", model_name)
      end
    end

    def update_environmentss
      default_mailer = "proj_name.com"
      action_mailer = ask("What is the action mailer domain (normally just the domain)? [#{default_mailer}]")
      action_mailer = default_mailer if action_mailer.blank?
      application(nil, :env => "production") do
        "config.action_mailer.default_url_options = { :host => #{action_mailer} }"
      end
      application(nil, :env => "test") do
        "config.action_mailer.default_url_options = { :host => 'localhost:3000' }"
      end
      application(nil, :env => "development") do
        "config.action_mailer.default_url_options = { :host => 'localhost:3000' }"
      end
    end

    def update_initializers
      gsub_file 'config/initializers/devise.rb', /config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"/ do
        default_mailer = "webmaster@proj_name.com"
        mailer_sender = ask("What is the mail sender address? [#{default_mailer}]")
        mailer_sender = default_mailer if mailer_sender.blank?
        "config.mailer_sender = \"#{mailer_sender}\""
      end
    end

    def add_default_layout
      template 'defaults.html.erb', 'app/views/layouts/defaults.html.erb'
    end

    def update_db
      if yes?("Would you like to migrate the database?")
        rake("db:migrate")
      end
    end

    end
  end
end 
