require 'ms/data/simple'

module Ms
  module Data
    module_function
    
    # Initializes a new interleaved data array.
    def new_interleaved(unresolved_data, n=2)
      Interleaved.new(unresolved_data, n=2)
    end
    
    # An Interleaved data array lazily evaluates it's unresolved data as 
    # an interleaved array of n members.  The unresolved data is evaluated 
    # into an array using to_a.
    #
    #   i = Ms::Data::Interleaved.new([1,4,2,5,3,6])
    #   i.unresolved_data    # => [1,4,2,5,3,6]
    #   i.data               # => []
    #   i[0]                 # => [1,2,3]
    #   i[1]                 # => [4,5,6]
    #   i.data               # => [[1,2,3], [4,5,6]]
    #
    class Interleaved < Simple
      attr_reader :n
      
      def initialize(unresolved_data, n=2)
        @n = 2
        super(unresolved_data)
      end
      
      def [](index)
        resolve.data[index]
      end
      
      def resolved?
        !@data.empty?
      end
    
      def resolve
        return(self) if resolved?
        
        unresolved_data = @unresolved_data.to_a
        
        unless unresolved_data.length % n == 0
          raise ArgumentError, "interleaved data must have a number of elements evenly divisible by n (#{n})"
        end
        
        n.times { @data << [] }
        map = @data * (unresolved_data.length/n)
        
        unresolved_data.each_with_index do |item, i|
          map[i] << item
        end

        self
      end
      
    end
  end
end