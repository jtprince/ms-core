require 'ms/data/interleaved'
require 'ms/data/transposed'

module Ms
  
  # The Data module contains a number of classes providing a standard way to
  # resolve various data storage formats into a 'simple' data array.
  #   
  #   type               format
  #   simple             [[mzs,...], [intensities...]]
  #   transposed         [[mz,intensity], [mz,intensity], ...]
  #   interleaved        [mz,intensity,mz,intensity,...]
  #
  # For instance:
  #
  #   s = Data.new([[1,2,3], [4,5,6]], :simple)
  #   s.resolve.data        # => [[1,2,3], [4,5,6]]
  #
  #   t = Data.new([[1,4],[2,5],[3,6]], :transposed)
  #   t.resolve.data        # => [[1,2,3], [4,5,6]]
  #
  #   i = Data.new([1,4,2,5,3,6], :interleaved)
  #   i.resolve.data        # => [[1,2,3], [4,5,6]]
  #
  # Data is always resolved by calling to_a on the unresolved data object
  # and then rearranging as needed (in the case of simple data, to_a is
  # also called on each member of the unresolved data array).  This lazy 
  # resolution allows the use of non-array unresolved_data objects such
  # as Data::LazyString:
  #
  #   str = [[1,4,2,5,3,6].pack("g*")].pack("m")
  #   unresolved_data = Data::LazyString.new(str)
  #
  #   i = Data.new(unresolved_data, :interleaved)
  #   i.resolve.data        # => [[1,2,3], [4,5,6]]
  #
  # Obviously the big advantage of lazy data resolution is that Data objects
  # may be instantiated cheaply while expensive operations like unpacking and
  # rearrangement may be put off or not executed at all.
  #
  module Data
    module_function
    
    # Initializes a new data array of the specified type by forwarding 
    # data to the "new_<type>" method.
    #
    #   simple = Ms::Data.new([[1,2,3], [4,5,6]], :simple)
    #   simple.class           # => Ms::Data::Simple
    # 
    #   interleaved = Ms::Data.new([1,4,2,5,3,6], :interleaved)
    #   interleaved.class      # => Ms::Data::Interleaved
    #
    def new(data, type=:simple)
      send("new_#{type}", data)  
    end
  end
end