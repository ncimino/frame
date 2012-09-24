require 'generators/frame'
require 'rails/generators/migration'
#require "omniauth-twitter"

module Frame
  module Generators
    class OmniauthGenerator < Base
    include Rails::Generators::Migration

    desc "Installs Devises Omniauth."

    def install_omniauth
      gem 'omniauth'
      gem 'oauth2'
      gem 'omniauth-twitter'
      gem 'omniauth-google-oauth2'

      Bundler.with_clean_env do
        run "bundle"
      end

      generate("migration AddColumnsToUsers provider:string uid:string")
      uncomment_lines('config/initializers/session_store.rb', "Tester::Application.config.session_store :active_record_store")
      generate("session_migration")
      rake("db:migrate")

      add_if_missing('app/models/user.rb', ":provider, :uid,", :after => "  attr_accessible ")
      add_if_missing('app/models/user.rb', ":omniauthable, ", :after => "  devise ")

      add_if_missing('config/routes.rb', ", :controllers => { :omniauth_callbacks => \"users/omniauth_callbacks\" }", :after => "  devise_for :users")

      template 'omniauth.rb', 'config/initializers/omniauth.rb'
      template 'omniauth_callbacks_controller.rb', 'app/controllers/users/omniauth_callbacks_controller.rb'

      add_if_missing('app/models/user.rb', '
      def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
        Rails.logger.debug "(DEBUG) auth: #{auth.to_yaml}"
        user = User.where(:provider => auth.provider, :uid => auth.uid).first
        unless user
                            #name:auth.extra.raw_info.name,
          user = User.create(
                             provider:auth.provider,
                             uid:auth.uid,
                             email:auth.info.email,
                             password:Devise.friendly_token[0,20]
          )
        end
        user
      end', :before => "\nend")

      add_if_missing('app/models/user.rb', '
      def self.find_for_google_oauth(auth, signed_in_resource=nil)
        Rails.logger.debug "(DEBUG) auth: #{auth.to_yaml}"
        user = User.where(:provider => auth.provider, :uid => auth.uid).first
        unless user
                            #name:auth.extra.raw_info.name,
          user = User.create(
                             provider:auth.provider,
                             uid:auth.uid,
                             email:auth.info.email,
                             password:Devise.friendly_token[0,20]
          )
        end
        user
      end', :before => "\nend")

      add_if_missing('Rakefile', "
files = ['config/initializers/omniauth.rb','config/database.yml','config/initializers/secret_token.rb']

domain = \"#{Rails.application.class.parent_name.downcase}.econtriver.com\"
user = \"root\"  # The server's user for deploys
deploy_to = \"/srv/www/\#{domain}\"

task :setup_server_db do
  system(\"ssh \#{user}@\#{domain} 'cd \#{File.join(deploy_to,'current')};rake db:setup RAILS_ENV=production'\")
end

task :put_secret do
  files.each do |f|
    system(\"scp \#{f} \#{user}@\#{domain}:\#{File.join(deploy_to,'private',f)}\")
  end
end

task :get_secret do
  files.each do |f|
    system(\"scp \#{user}@\#{domain}:\#{File.join(deploy_to,'private',f)} \#{f}\")
  end
end", :after => "Tester::Application.load_tasks\n")


      gsub_file 'config/environments/production.rb', /config\.assets\.compile = false/, 'config.assets.compile = true'

    end

    end
  end
end 
