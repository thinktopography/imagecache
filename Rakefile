$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rake/testtask'
require 'bundler/version'
require './lib/imagecache'
require './lib/imagecache/version'

Rake::TestTask.new do |t|
  t.libs << '.' << 'lib' << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = false
end

desc "Build the gem"
task :build do
  system "gem build imagecache.gemspec"
end

desc "install the gem"
task :install do
  system "gem install imagecache-#{Imagecache::VERSION}.gem"
end

desc "Build and release the gem"
task :release => :build do
  system "gem push imagecache-#{Imagecache::VERSION}.gem"
end
