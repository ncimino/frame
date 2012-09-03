require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class MysqlGenerator < Base
    include Rails::Generators::Migration

    desc "Update MySQL with user priveleges."

    def add_user
      config = YAML.load_file('config/database.yml')
      user = config[Rails.env]["username"]
      pw = config[Rails.env]["password"]
      puts "creating user: #{user}"
      puts "using pw: #{pw}"
      output = create_file 'tmp/create_user.sql', "CREATE USER '#{user}'@localhost IDENTIFIED BY '#{pw}';"
      puts "output: #{output}"
      system "mysql -u root -p < #{output}"
    end

    def grant_user
      config = YAML.load_file('config/database.yml')
      user = config[Rails.env]["username"]
      db = config[Rails.env]["database"]
      puts "granting user: #{user}"
      puts "all on db: #{db}"
      output = create_file 'tmp/grant_user.sql', "GRANT ALL PRIVILEGES ON #{db}.* TO '#{user}'@localhost;"
      puts "output: #{output}"
      system "mysql -u root -p < #{output}"
    end

    end
  end
end 
