require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class AdminGenerator < Base
    include Rails::Generators::Migration

    desc "Installs Active Admin."

    def add_gems
      #add_gem("active_admin")
      add_gem("sass-rails", :group => "test")
      add_gem("meta_search", :group => "test")
    end

    def install_active_admin
      #gem("sass-rails", :group => "test")
      #gem("meta_search", :group => "test")

      if yes?("Would you like to install Active Admin?")
        gem("activeadmin")
        Bundler.with_clean_env do
          run "bundle install"
        end
        generate("active_admin:install")
        default_model = "page"
        generate("active_admin:resource #{default_model}")
      end
    end

    def update_db
      if yes?("Would you like to migrate the database?")
        rake("db:migrate")
      end
    end

    def update_admin_form
      template 'pages.rb', 'app/admin/pages.rb'
    end

    def remove_pages_cud
      #remove the pages create, update, and destroy - leave reading
    end

    private

    def destination_path(path)
      File.join(destination_root, path)
    end

    end
  end
end 
