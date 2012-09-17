require 'bundler'
require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class PagesGenerator < Base
      include Rails::Generators::Migration

      desc "Setup Pages."

      class_option :force, :type => :boolean, :default => false, :desc => "Force file regeneration"

      #def add_gems
      #  #add_gem "mysql2"
      #  gem("mysql2")
      #  gem("activerecord-mysql2-adapter")
      #  comment_lines 'Gemfile', /gem 'sqlite3'/
      #  #run "bundle"
      #  Bundler.with_clean_env do
      #    #run "gem install activerecord-mysql2-adapter"
      #    run "bundle"
      #  end
      #  #Bundler.install
      #end

      def remove_index
        filename="public/index.html"
        if File.exists?(filename) and yes?("Would you like to remove '#{filename}'?")
          remove_file filename
        end
      end

      def generate_scaffold
        generate("scaffold", "Page name:string title:string location:string content:text url:string ordinal:integer")
        append_to_file 'db/seeds.rb' do
          "\nPage.create(:name => 'Home', :title => 'Welcome to Home!', :content => '<h2>Content</h2>This is the content of the home page...', :location => 'topbar', :url => '', :ordinal => '1')\n"
        end
        generate("scaffold_controller", "Page")
      end

      def add_root_route
        insert_into_file 'config/routes.rb', "  root :to => 'pages#show', :id => 0\n", :after => "#{Rails.application.class.parent_name}::Application.routes.draw do\n"
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
        gsub_file 'app/controllers/pages_controller.rb', /format.html # show.html.erb\n      format.json { render json: @page }/ do
          "# show.html.erb
      if @page
        format.html
        format.json { render json: @page }
      else
        format.html { redirect_to action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
        "
        end
      end

      def create_pages_partials
        template '_links.html.erb', 'app/views/pages/_links.html.erb'
        template '_form.html.erb', 'app/views/pages/_form.html.erb'
        template '_error_messages.html.erb', 'app/views/shared/_error_messages.html.erb'
        template '_sidebar.html.erb', 'app/views/shared/_sidebar.html.erb'
        template '_page.html.erb', 'app/views/pages/_page.html.erb'
      end

      def create_pages_views
        template 'pages.html.erb', 'app/views/layouts/pages.html.erb'
        template 'index.html.erb', 'app/views/pages/index.html.erb'
        template 'show.html.erb', 'app/views/pages/show.html.erb'
      end

      def add_scopes
        #run "bundle"

        string='
      validates_presence_of :name

      scope :topbar, where(:location => "topbar")
      scope :sidebar, where(:location => "sidebar")
      scope :userbar, where(:location => "userbar")
      scope :bottombar, where(:location => "bottombar")

'
        insert_into_file 'app/models/page.rb', string, :after => "class Page < ActiveRecord::Base\n"

#      inject_into_class "app/models/page.rb", Page do
#      '
#      validates_presence_of :name
#
#      scope :topbar, where(:location => "topbar")
#      scope :sidebar, where(:location => "sidebar")
#      scope :userbar, where(:location => "userbar")
#      scope :bottombar, where(:location => "bottombar")
#
#'
#      end
    end

    def add_application_page_loader
      inject_into_class "app/controllers/application_controller.rb", ApplicationController do '
  before_filter :get_variables

  def get_variables
    @display_pages = Page.order("ordinal")
  end

'
      end
    end

    def update_db
      if yes?("Would you like to migrate the database?")
        rake("db:migrate")
        rake("db:seed")
      end
    end

    private

    def destination_path(path)
      File.join(destination_root, path)
    end

  end
end
end
