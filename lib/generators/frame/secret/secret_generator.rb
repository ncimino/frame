require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class SecretGenerator < Base
    include Rails::Generators::Migration

    desc "Installs Secret files if they don't already exist."
      
    # Commandline options can be defined here using Thor-like options:
    #class_option :my_opt, :type => :boolean, :default => false, :desc => "My Option"

    # I can later access that option using:
    #def opt
    #  puts options.my_opt
    #end
      
    def create_secret
      template 'database.yml', 'config/database.yml'
    end

    end
  end
end 
