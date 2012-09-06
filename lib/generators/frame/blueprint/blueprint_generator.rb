require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class BlueprintGenerator < Base
    #include Rails::Generators::Migration

    desc "Installs Blueprint-CSS."

    def clone_blueprint
      #system('git clone git@github.com:joshuaclayton/blueprint-css')
      #cd blueprint-css/lib
      #sudo bundle install --without test
      #ruby compress.rb -o path/to/project/app/assets/stylesheets
    end



    end
  end
end 
