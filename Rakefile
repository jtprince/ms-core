require 'rubygems'
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "ms-core"
  gem.homepage = "http://github.com/jtprince/ms-core"
  gem.license = "MIT"
  gem.summary = %Q{basic, shared functionality for mspire libraries}
  gem.description = %Q{basic, shared functionality for mspire libraries.}
  gem.email = "jtprince@gmail.com"
  gem.authors = ["John T. Prince", "Simon Chiang"]
  gem.rubyforge_project = 'mspire'
  gem.add_runtime_dependency 'bio', '>= 1.4.1'
  gem.add_development_dependency "spec-more", ">= 0"
  gem.add_development_dependency "jeweler", "~> 1.5.2"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

#require 'rcov/rcovtask'
#Rcov::RcovTask.new do |spec|
#  spec.libs << 'spec'
#  spec.pattern = 'spec/**/*_spec.rb'
#  spec.verbose = true
#end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ms-core #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
