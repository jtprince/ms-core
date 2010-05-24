require 'rubygems'
require 'rake'
require 'jeweler'
require 'rcov/rcovtask'
require 'rake/rdoctask'
require 'rake/testtask'

Jeweler::Tasks.new do |gem|
  gem.name = "ms-core"
  gem.summary = "basic, shared functionality for mspire libraries"
  gem.description = "basic, shared functionality for mspire libraries"
 gem.email = "jtprince@gmail.com"
  gem.homepage = "http://github.com/jtprince/ms-core/rdoc"
  gem.authors = ["Simon Chiang", "John Prince"]
  # dependencies:
  gem.add_dependency("molecules", ">= 0.2.0")

  # dev dependencies:
  gem.add_development_dependency "spec-more", ">= 0"
end

Rake::TestTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

Rcov::RcovTask.new do |spec|
  spec.libs << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

task :default => :spec

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ms-core #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
