require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class MysqlGenerator < Base
    include Rails::Generators::Migration

    desc "Update MySQL with user privileges."

    def add_gems
      gem("mysql2")
      comment_lines 'Gemfile', /gem 'sqlite3'/
      Bundler.with_clean_env do
        run "bundle"
      end
    end

    def drop_db
      config = YAML.load_file('config/database.yml')
      db = config[Rails.env]["database"]
      puts "database: #{db}"
      output = create_file 'tmp/drop_db.sql', "DROP DATABASE IF EXISTS #{db};"
      puts "output: #{output}\nEnter mysql root password"
      system "mysql -u root < #{output}"
    end

    def add_user
      config = YAML.load_file('config/database.yml')
      user = config[Rails.env]["username"]
      pw = config[Rails.env]["password"]
      puts "creating user: #{user}"
      puts "using pw: #{pw}"
      output = create_file 'tmp/create_user.sql', "CREATE USER '#{user}'@localhost IDENTIFIED BY '#{pw}';"
      puts "output: #{output}\nEnter mysql root password"
      system "mysql -u root < #{output}"
    end

    def grant_user
      config = YAML.load_file('config/database.yml')
      user = config[Rails.env]["username"]
      db = config[Rails.env]["database"]
      puts "granting user: #{user}"
      puts "all on db: #{db}"
      output = create_file 'tmp/grant_user.sql', "GRANT ALL PRIVILEGES ON #{db}.* TO '#{user}'@localhost;"
      puts "output: #{output}\nEnter mysql root password"
      system "mysql -u root < #{output}"
    end

    def create_db
      rake("db:reset")
      rake("db:setup")
    end

    end
  end
end 
