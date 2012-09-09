require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class BlueprintGenerator < Base
    #include Rails::Generators::Migration

    desc "Installs Blueprint-CSS."

    def clone_blueprint
      tmp_dir=File.join(Rails.root, 'tmp/blueprint')
      dest_dir=File.join(Rails.root, 'app/assets/stylesheets')

      if Dir.exist?(tmp_dir)
        FileUtils.rm_rf(tmp_dir)
      end
      system("git clone git@github.com:joshuaclayton/blueprint-css #{tmp_dir}")
      Dir.chdir tmp_dir
      system("git checkout v1.0.1")
      Dir.chdir File.join(tmp_dir, 'lib')
      #system("sudo bundle install --without test")
      system("bundle install --without test")
      system("ruby compress.rb -o #{dest_dir}")   \

      puts "\n\n==> Added the following to you app/assets/stylesheets/application.css file:\n *= require ie\n *= require screen"

      end

    end
  end
end 
