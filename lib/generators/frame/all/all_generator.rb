require 'generators/frame'
require 'rails/generators/migration'

module Frame
  module Generators
    class AllGenerator < Base
    include Rails::Generators::Migration

    desc "Installs All of Frame for a new project."

    def generate_all
      generate("frame:gitignore")
      generate("frame:secret")
      generate("frame:mysql")
      generate("frame:pages")
      generate("frame:layout")
      generate("frame:blueprint")
      generate("frame:devise")
      generate("frame:admin")
    end

    end
  end
end 
