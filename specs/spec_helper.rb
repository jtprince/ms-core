require 'rubygems'
require 'tap/spec'
require 'minitest/mock'

module Testdata
  TEST_FILES = File.expand_path(File.join(File.dirname(__FILE__), "../test_files"))
  TEST_FILES_LARGE = File.expand_path(File.join(File.dirname(__FILE__), "../test_files_large"))
  
  def self.included(base)
    super
    base.acts_as_subset_test
  end
  
  module_function
  
  def test_path(*paths)
    File.join(TEST_FILES, *paths)
  end
  
  def spec_large_path(*paths)
    File.join(TEST_FILES_LARGE, *paths)
  end
  
  def spec_large(&block)
    subset_test("LARGE", "l", &block)
  end
end