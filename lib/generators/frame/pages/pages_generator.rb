require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class PagesGenerator < Base
    include Rails::Generators::Migration

    desc "Setup Pages."

    def add_gems
      add_gem "mysql2"
    end

    def remove_index
      remove_file "public/index.html"
    end

    def generate_scaffold
      generate("scaffold", "Page name:string title:string location:string content:text active:boolean url:string ordinal:integer")
      append_to_file 'db/seeds.rb' do
        "Page.create(:name => 'home', :title => 'Welcome to Home!', :content => '<h2>Content</h2>This is the content of the home page...', :location => 'topbar')"
      end
    end

    def add_page_helpers
      template 'application_helper.rb', 'app/helpers/application_helper.rb'
    end

    def replace_html_app
      template 'application.html.erb', 'app/views/layouts/application.html.erb'
    end

    def destination_path(path)
      File.join(destination_root, path)
    end

    end
  end
end

