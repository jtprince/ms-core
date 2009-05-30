require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/clean'

require 'tap/constants'

#
# Gem specification
#

gemspec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = "ms-core"
  s.version = "0.0.1"
  s.summary = "the core, shared library for mspire"
  s.date = Time.now.strftime("%Y-%m-%d")
  s.email = "jtprince@gmail.com"
  s.homepage = "http://mspire.rubyforge.org/projects/ms-core/"
  s.rubyforge_project = "mspire"
  s.has_rdoc = true
  s.authors = ["John Prince", "Simon Chiang"]
  s.add_development_dependency("tap", ">= 0.11.2")
  s.add_development_dependency("minitest", "= 1.3.0")
  s.add_dependency("molecules", ">= 0.2.0")

  # list extra rdoc files like README here.
  s.extra_rdoc_files = %W{
    changelog.txt
    LICENSE
    README
  }
  s.files = Dir["lib/**/*.rb"]
end


Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_tar = true
end

desc 'Prints the gemspec manifest.'
task :print_manifest do
  # collect files from the gemspec, labeling 
  # with true or false corresponding to the
  # file existing or not
  files = gemspec.files.inject({}) do |files, file|
    files[File.expand_path(file)] = [File.exists?(file), file]
    files
  end
  
  # gather non-rdoc/pkg files for the project
  # and add to the files list if they are not
  # included already (marking by the absence
  # of a label)
  Dir.glob("**/*").each do |file|
    next if file =~ /^(rdoc|pkg|backup)/ || File.directory?(file)
    
    path = File.expand_path(file)
    files[path] = ["", file] unless files.has_key?(path)
  end
  
  # sort and output the results
  files.values.sort_by {|exists, file| file }.each do |entry| 
    puts "%-5s %s" % entry
  end
end

#
# Documentation tasks
#

desc 'Generate documentation.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  spec = gemspec
  
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'mspire'
  rdoc.main     = 'README'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include( spec.extra_rdoc_files )
  rdoc.rdoc_files.include( spec.files.select {|file| file =~ /^lib.*\.rb$/} )
end

desc "Publish RDoc to RubyForge"
task :publish_rdoc => [:rdoc] do
  require 'yaml'
  
  config = YAML.load(File.read(File.expand_path("~/.rubyforge/user-config.yml")))
  host = "#{config["username"]}@rubyforge.org"
  
  rsync_args = "-v -c -r"
  remote_dir = "/var/www/gforge-projects/mspire/projects/ms-core"
  local_dir = "rdoc"
 
  #sh %{rsync #{rsync_args} #{local_dir}/ #{host}:#{remote_dir}}
  puts "rsync #{rsync_args} #{local_dir}/ #{host}:#{remote_dir}"
end

#
# Dependency tasks
#

###############################################
# GLOBAL
###############################################
# FL = FileList
# 
# NAME = "mspire"
# 
# $dependencies = %w(libjtp)
# $tfiles_large = 'test_files_large'
# changelog = "changelog.txt"
# 
# core_files = FL["INSTALL", "README", "README.rdoc", "Rakefile", "LICENSE", changelog, "release_notes.txt", "{lib,bin,script,specs,tutorial,test_files}/**/*"]
# big_dist_files = core_files + FL["test_files_large/**/*"]
# 
# dist_files = core_files 
# # dist_files = big_dist_files

###############################################
# ENVIRONMENT
###############################################

# ENV["OS"] == "Windows_NT" ? WIN32 = true : WIN32 = false
# $gemcmd = "gem"
# if WIN32
#   unless ENV["TERM"] == "cygwin"
#     $gemcmd << ".cmd"
#   end
# end

task :ensure_dependencies do
  gemspec.dependencies.each do |dependency|
    if Gem.source_index.find_name(dependency.name, dependency.version_requirements).empty?
      abort "ABORTING: install #{dependency} before testing!"
    end
  end
end

task :ensure_large_testfiles do
  # if !File.exist?($tfiles_large) and !ENV['SPEC_LARGE'].nil?
  #   warn "Not running with large files since #{$tfiles_large} does not exist!"
  #   warn "Removing SPEC_LARGE from ENV!"
  #   ENV.delete('SPEC_LARGE')
  # end
end

task :ensure_gem_is_uninstalled do
  # reply = `#{$gemcmd} list -l #{NAME}`
  # if reply.include? NAME + " ("
  #   puts "GOING to uninstall gem '#{NAME}' for testing"
  #   if WIN32
  #     %x( #{$gemcmd} uninstall -x #{NAME} )
  #   else
  #     %x( sudo #{$gemcmd} uninstall -x #{NAME} )
  #   end
  # end
end

#
# test tasks 
#

desc "Run specs."
task(:spec, :pattern) do |task, args|
  pattern = Regexp.new(args.pattern || '.')
  specs = Dir.glob("specs/**/*_spec.rb").select {|spec| spec =~ pattern }
  sh('ruby', "-w", "-I", "lib", "-e", "ARGV.each {|spec| load spec}", *specs)
end
