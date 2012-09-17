require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class MysqlGenerator < Base
    include Rails::Generators::Migration

    desc "Update MySQL with user priveleges."


    #def reset_db
    #  Bundler.with_clean_env do
    #    run "gem install activerecord-mysql2-adapter"
    #    run "bundle"
    #  end
    #  begin
    #    rake("db:reset")
    #  rescue
    #    puts "Error #{$!}"
    #  ensure
    #    #this_code_will_execute_always()
    #  end
    #end

    def add_gems
      #add_gem "mysql2"
      gem("mysql2")
      #gem("activerecord-mysql2-adapter")
      comment_lines 'Gemfile', /gem 'sqlite3'/
      #run "bundle"
      Bundler.with_clean_env do
        #run "gem install activerecord-mysql2-adapter"
        run "bundle"
      end
      #Bundler.install
    end

    def drop_db
      config = YAML.load_file('config/database.yml')
      db = config[Rails.env]["database"]
      #host = config[Rails.env]["host"]
      puts "database: #{db}"
      #puts "host: #{host}"
      output = create_file 'tmp/drop_db.sql', "DROP DATABASE IF EXISTS #{db};"
      puts "output: #{output}\nEnter mysql root password"
      system "mysql -u root -p < #{output}"
    end

    def add_user
      config = YAML.load_file('config/database.yml')
      user = config[Rails.env]["username"]
      pw = config[Rails.env]["password"]
      puts "creating user: #{user}"
      puts "using pw: #{pw}"
      output = create_file 'tmp/create_user.sql', "CREATE USER '#{user}'@localhost IDENTIFIED BY '#{pw}';"
      puts "output: #{output}\nEnter mysql root password"
      system "mysql -u root -p < #{output}"
    end

    def grant_user
      config = YAML.load_file('config/database.yml')
      user = config[Rails.env]["username"]
      db = config[Rails.env]["database"]
      puts "granting user: #{user}"
      puts "all on db: #{db}"
      output = create_file 'tmp/grant_user.sql', "GRANT ALL PRIVILEGES ON #{db}.* TO '#{user}'@localhost;"
      puts "output: #{output}\nEnter mysql root password"
      system "mysql -u root -p < #{output}"
    end

    def create_db
      rake("db:setup")
    end

    end
  end
end 
