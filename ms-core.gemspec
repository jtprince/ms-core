Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = "ms-core"
  s.version = "0.0.2"
  s.summary = "basic, shared functionality for mspire libraries"
  s.date = Time.now.strftime("%Y-%m-%d")
  s.authors = ["Simon Chiang", "John Prince"]
  s.email = ["jtprince@gmail.com"]
  s.homepage = "http://mspire.rubyforge.org/ms-core/"
  s.require_path = "lib"
  #s.test_file = "spec/tap_spec_suite.rb"
  s.rubyforge_project = "mspire"
  s.has_rdoc = true

  # DEPENDENCIES:
  s.add_dependency("molecules", ">= 0.2.0")

  s.add_development_dependency("tap", ">= 0.11.2")
  s.add_development_dependency("minitest", ">= 1.3.0")
  
  s.extra_rdoc_files = %W{
    README.rdoc
    MIT-LICENSE
    History
  }
  
  s.files = %W{
    MIT-LICENSE
    README.rdoc
    History
    lib/ms.rb
    lib/ms/calc.rb
    lib/ms/data.rb
    lib/ms/data/interleaved.rb
    lib/ms/data/lazy_io.rb
    lib/ms/data/lazy_string.rb
    lib/ms/data/simple.rb
    lib/ms/data/transposed.rb
    lib/ms/format/format_error.rb
    lib/ms/id/peptide.rb
    lib/ms/id/protein.rb
    lib/ms/id/search.rb
    lib/ms/mass.rb
    lib/ms/mass/aa.rb
    lib/ms/spectrum.rb
    lib/ms/support/binary_search.rb
  }
end
