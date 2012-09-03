require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class PagesGenerator < Base
    include Rails::Generators::Migration

    desc "Setup Pages."

    class_option :force, :type => :boolean, :default => false, :desc => "Force file regeneration"

    def add_gems
      add_gem "mysql2"
    end

    def remove_index
      #remove_file "public/index.html"
    end

    def generate_scaffold
      generate("scaffold", "Page name:string title:string location:string content:text url:string ordinal:integer")
      append_to_file 'db/seeds.rb' do
        "Page.create(:name => 'home', :title => 'Welcome to Home!', :content => '<h2>Content</h2>This is the content of the home page...', :location => 'topbar')"
      end
      generate("scaffold_controller", "Page")
    end

    def add_root_route
      insert_into_file 'config/routes.rb', "root :to => 'pages#show', :id => 0\n", :after => "#{Rails.application.class.parent_name}::Application.routes.draw do\n"
    end

    def update_page_controller
      comment_lines 'app/controllers/pages_controller.rb', /@pages = Page.all/
      gsub_file 'app/controllers/pages_controller.rb', /def show\n\s+\@page \= Page\.find\(params\[\:id\]\)/ do
  "def show
    if params[:id] == 0
      @page = Page.find_by_name('home') || Page.first
    else
      @page = Page.find(params[:id])
    end"
      end
    end

    def create_links_partial
      template '_links.html.erb' 'app/views/pages/_links.html.erb'
      template '_error_messages.html.erb' 'app/views/shared/_error_messages.html.erb'
      template '_sidebar.html.erb' 'app/views/shared/_sidebar.html.erb'
    end

    def add_scopes
      inject_into_class "app/models/page.rb", Page do
      '
      validates_presence_of :name

      scope :topbar, where(:location => "topbar")
      scope :sidebar, where(:location => "sidebar")
      scope :userbar, where(:location => "userbar")
      scope :bottombar, where(:location => "bottombar")

'
      end
    end

    def application_page_loader
      inject_into_class "app/controllers/application_controller.rb", ApplicationController do '
  before_filter :get_variables

  def get_variables
    @display_pages = Page.where("location <> \'off\'")
  end

'
      end
    end

    private

    def destination_path(path)
      File.join(destination_root, path)
    end

    end
  end
end
