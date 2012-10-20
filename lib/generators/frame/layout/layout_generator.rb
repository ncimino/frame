require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class LayoutGenerator < Base
    include Rails::Generators::Migration

    desc "Setup Pages."

    class_option :force, :type => :boolean, :default => false, :desc => "Force file regeneration"

    def remove_index
      filename="public/index.html"
      #if File.exists?(filename) and yes?("Would you like to remove '#{filename}'?")
        remove_file filename
      #end
    end

    def add_default_layout
      template('app/views/layouts/defaults.html.erb')
      template('app/views/layouts/default_layout.html.erb')
    end

    def add_page_helpers
      template('app/helpers/application_helper.rb')
    end

    def add_images
      template('app/assets/images/econ_f_64.gif')
      template('app/assets/images/favicon.ico')
    end

    def replace_html_app
      @title = Rails.application.class.parent_name
      template('app/views/layouts/application.html.erb')
    end

    def copy_css
      template('app/assets/stylesheets/frame.css')
      add_if_missing('app/assets/stylesheets/application.css', " *= require frame\n", :after => " *= require_self\n")
    end

    private

    def destination_path(path)
      File.join(destination_root, path)
    end

    end
  end
end
