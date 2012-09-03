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
        model_name = ask("What would you like the user model to be called? [user]")
        model_name = "user" if model_name.blank?
        generate("devise", model_name)
      end
    end

    #test/development:
    #    config.action_mailer.default_url_options = { :host => 'localhost:3000' }
    #production:
    #    config.action_mailer.default_url_options = { :host => 'proj_name.com' }

    end
  end
end 
