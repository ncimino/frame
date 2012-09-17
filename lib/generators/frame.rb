require 'rails/generators/base'

module Frame
  module Generators
    class Base < Rails::Generators::Base #:nodoc:
      def self.source_root
        @_frame_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'frame', generator_name, 'templates'))
      end

      #def self.banner
      #  "rails generate frame:#{generator_name} #{self.arguments.map{ |a| a.usage }.join(' ')} [options]"
      #end

      private

      def add_if_missing(file, string, options = {})
        puts "\n\n==> Adding the following to '#{file}' file:\n'#{string}' unless it already exists"
        file_content = File.read(file)
        #File.open(file, 'a') { |f| f.write("\n") } unless file_content =~ /\n\Z/
        insert_into_file file, string, options unless file_content.include? string
      end

      def add_gem(name, options = {})
        #add_if_missing(destination_path("Gemfile"),)
        gemfile_content = File.read(destination_path("Gemfile"))
        File.open(destination_path("Gemfile"), 'a') { |f| f.write("\n") } unless gemfile_content =~ /\n\Z/
        gem name, options unless gemfile_content.include? name
      end

      #def print_usage
      #  self.class.help(Thor::Base.shell.new)
      #  exit
      #end
    end
  end
end

