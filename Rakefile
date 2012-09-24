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

task :build_gem do
  gem_version = ask("What is the gem version (x.x.x)?")
  system("gem build frame.gemspec")
  system("gem push mygem-#{gem_version}.gem")
  system("git tag -a v#{gem_version} -m 'version #{gem_version}'")
  system("git push --tags")
end