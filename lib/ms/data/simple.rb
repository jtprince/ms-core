module Ms
  module Data
    module_function
    
    # Initializes a new simple data array.
    def new_simple(unresolved_data)
      Simple.new(unresolved_data)
    end
    
    # A Simple data array that lazily evaluates unresolved_data, and
    # each member of unresolved_data using to_a:
    # 
    #   class LazyObject
    #     attr_reader :to_a
    #     def initialize(array)
    #       @to_a = array
    #     end
    #   end
    #
    #   a = LazyObject.new([1,2,3])
    #   b = LazyObject.new([4,5,6])
    #   s = Ms::Data::Simple.new([a, b])
    #
    #   s.unresolved_data     # => [a, b]
    #   s.data                # => []
    #   s[0]                  # => [1,2,3]
    #   s[1]                  # => [4,5,6]
    #   s.data                # => [[1,2,3], [4,5,6]]
    #
    class Simple
      # The underlying resolved data store.
      attr_reader :data
      
      # The underlying unresolved data store.
      attr_reader :unresolved_data
      
      def initialize(unresolved_data)
        @data = []
        @unresolved_data = unresolved_data
      end
      
      def [](index)
        @data[index] ||= @unresolved_data.to_a[index].to_a 
      end
      
      def resolve
        0.upto(@unresolved_data.length - 1) do |index| 
          self[index]
        end unless resolved?
        
        self
      end
      
      def resolved?
        @data.compact.length == @unresolved_data.length
      end
    end
  end
end