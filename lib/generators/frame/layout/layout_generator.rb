require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class LayoutGenerator < Base
    include Rails::Generators::Migration

    desc "Setup Pages."

    class_option :force, :type => :boolean, :default => false, :desc => "Force file regeneration"

    def add_gems
      add_gem "mysql2"
    end

    def remove_index
      #remove_file "public/index.html"
    end

    def add_default_layout
      template 'defaults.html.erb', 'app/views/layouts/defaults.html.erb'
      template 'default_layout.html.erb', 'app/views/layouts/default_layout.html.erb'
    end

    def add_page_helpers
      template 'application_helper.rb', 'app/helpers/application_helper.rb'
    end

    def replace_html_app
      @title = Rails.application.class.parent_name
      template 'application.html.erb', 'app/views/layouts/application.html.erb'
    end

    private

    def destination_path(path)
      File.join(destination_root, path)
    end

    end
  end
end
