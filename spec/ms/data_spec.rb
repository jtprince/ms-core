require File.dirname(__FILE__) + "/../spec_helper.rb"
require 'ms/data'

describe "Data.new" do
  it "satisfies documentation" do
    s = Ms::Data.new([[1,2,3], [4,5,6]], :simple)
    s.resolve.data.is [[1,2,3], [4,5,6]]
  
    t = Ms::Data.new([[1,4],[2,5],[3,6]], :transposed)
    t.resolve.data.is [[1,2,3], [4,5,6]]
  
    i = Ms::Data.new([1,4,2,5,3,6], :interleaved)
    i.resolve.data.is [[1,2,3], [4,5,6]]
  
    str = [[1,4,2,5,3,6].pack("g*")].pack("m")
    unresolved_data = Ms::Data::LazyString.new(str)
  
    i = Ms::Data.new(unresolved_data, :interleaved)
    i.resolve.data.is [[1,2,3], [4,5,6]]
  end
  
  it "should return a new data of the specified type" do
    data = Ms::Data.new([[1,2,3], [4,5,6]])
    data.class.is Ms::Data::Simple
    
    data = Ms::Data.new([[1,2,3], [4,5,6]], :simple)
    data.class.is Ms::Data::Simple
    
    data = Ms::Data.new([1,4,2,5,3,6], :interleaved)
    data.class.is Ms::Data::Interleaved
    
    data = Ms::Data.new([[1,4],[2,5],[3,6]], :transposed)
    data.class.is Ms::Data::Transposed
  end
end
