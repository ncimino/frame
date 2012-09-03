require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class SecretGenerator < Base
    include Rails::Generators::Migration

    desc "Installs Secret files if they don't already exist."

    class_option :force, :type => :boolean, :default => false, :desc => "Force file regeneration"

    #def opt
    #  puts options.force
    #end
      
    def create_database
      config = YAML.load_file(File.expand_path(File.join(File.dirname(__FILE__), 'templates', 'database.yml')))

      ['development','test','production'].each do |i|
        config["#{i}"]["database"] = Rails.application.class.parent_name.downcase
        config["#{i}"]["username"] = "#{Rails.application.class.parent_name.downcase}admin"
      end

      create_file 'config/database.yml', YAML.dump(config)
    end

    def create_secret_token
      secret = `rake secret`.rstrip
      initializer("secret_token.rb", "#{Rails.application.class.parent_name}::Application.config.secret_token = '#{secret}'")
    end

    end
  end
end 
