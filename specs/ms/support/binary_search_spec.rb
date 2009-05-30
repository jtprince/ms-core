require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper.rb")
require 'ms/support/binary_search'

describe Ms::Support::BinarySearch do
  acts_as_subset_test
  
  include Ms::Support::BinarySearch
  
  it "should satisfy documentation" do
    search_first(%w(a b c c c d e f)) {|x| x <=> "c"}.must_equal 2
    search_last(%w(a b c c c d e f)) {|x| x <=> "c"}.must_equal 4
    search_first(%w(a b c e f)) {|x| x <=> "c"}.must_equal 2
    search_first(%w(a b e f)) {|x| x <=> "c"}.must_equal nil
    search_last(%w(a b e f)) {|x| x <=> "c"}.must_equal nil
    search_lower_boundary(%w(a b e f)) {|x| x <=> "c"}.must_equal 2
    search_upper_boundary(%w(a b e f)) {|x| x <=> "c"}.must_equal 2
    search_range(%w(a b c c c d e f)) {|x| x <=> "c"}.must_equal(2...5)
    search_range(%w(a b c d e f)) {|x| x <=> "c"}.must_equal(2...3)
    search_range(%w(a b d e f)) {|x| x <=> "c"}.must_equal(2...2)
  end
  
  it "should be fast" do
    benchmark_test(25) do |x|
      array = (0..100000).to_a
      
      x.report("100k/1kx search_range") do 
        1000.times do 
          search_range(array) {|x| x <=> 88 }
        end
      end
    end
  end

end