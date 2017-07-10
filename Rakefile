# encoding: utf-8

require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
    gem.name = "microsoft_rsa"
    gem.homepage = "http://github.com/jasonwbarnett/microsoft_rsa"
    gem.license = "MIT"
    gem.summary = %Q{Microsoft RSAKeyValue XML structure support for Ruby}
    gem.description = %Q{This gem enables you to convert RSAKeyValue XML structures to OpenSSL RSA Private Key and vice versa}
    gem.email = "jason.w.barnett@gmail.com"
    gem.authors = ["Jason Barnett"]
    # dependencies defined in Gemfile
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError => e
  $stderr.puts e.message + " (normal in CI environment -- otherwise run `bundle install`)"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "microsoft_rsa #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
