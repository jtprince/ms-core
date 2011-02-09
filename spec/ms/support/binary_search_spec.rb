require "spec_helper.rb"
require 'ms/support/binary_search'

describe 'binary searching' do
  extend Ms::Support::BinarySearch
  
  it "satisfies documentation" do
    search_first(%w(a b c c c d e f)) {|x| x <=> "c"}.is 2
    search_last(%w(a b c c c d e f)) {|x| x <=> "c"}.is 4
    search_first(%w(a b c e f)) {|x| x <=> "c"}.is 2
    search_first(%w(a b e f)) {|x| x <=> "c"}.is nil
    search_last(%w(a b e f)) {|x| x <=> "c"}.is nil
    search_lower_boundary(%w(a b e f)) {|x| x <=> "c"}.is 2
    search_upper_boundary(%w(a b e f)) {|x| x <=> "c"}.is 2
    search_range(%w(a b c c c d e f)) {|x| x <=> "c"}.is(2...5)
    search_range(%w(a b c d e f)) {|x| x <=> "c"}.is(2...3)
    search_range(%w(a b d e f)) {|x| x <=> "c"}.is(2...2)
  end
  
  it "is fast" do
    start = Time.now
    if ENV['BENCHMARK']
      Benchmark.bm(25) do |x|
        array = (0..100000).to_a

        x.report("100k/1kx search_range") do 
          1000.times do 
            search_range(array) {|x| x <=> 88 }
          end
        end
      end
    end
    true.is true
  end
end
