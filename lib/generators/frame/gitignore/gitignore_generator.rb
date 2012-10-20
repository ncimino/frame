require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class GitignoreGenerator < Base
    include Rails::Generators::Migration

    desc "Installs Gitignore if it doesn't already exist."
      
    def create_gitignore
      template ".gitignore"
    end

    end
  end
end 
