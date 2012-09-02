#require 'rubygems'
#require 'rake'
#require 'cucumber'
#require 'cucumber/rake/task'
#
#Cucumber::Rake::Task.new(:features) do |t|
#  t.cucumber_opts = "features --format progress"
#end
#
#task :default => :features

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test
