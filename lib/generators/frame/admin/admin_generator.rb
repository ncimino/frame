require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class AdminGenerator < Base
    include Rails::Generators::Migration

    desc "Installs Active Admin."

    def add_gems
      add_gem("sass-rails", :group => "test")
      add_gem("meta_search", :group => "test")
    end

    def install_active_admin
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

    def update_pages_controller
      template 'pages_controller.rb', 'app/controller/pages_controller.rb'
    end

    def cleanup_page_routes
      file='config/routes.rb'
      add_if_missing(file, "  match 'pages/:id' => 'pages#show'", :after => "  resources :pages\n")
      comment_lines file, /  resources :pages/
    end

    def remove_pages_cud
      filenames = ["app/views/pages/new.html.erb", "app/views/pages/edit.html.erb", "app/views/pages/index.html.erb", "app/views/pages/_form.html.erb"]
        filenames.each { |filename|
          if File.exists?(filename) and yes?("Would you like to remove '#{filename}'?")
            remove_file filename
          end
        }
      template 'show.html.erb', 'app/views/pages/show.html.erb'
    end

    private

    def destination_path(path)
      File.join(destination_root, path)
    end

    end
  end
end 
