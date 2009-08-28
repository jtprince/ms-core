require 'ms/data/simple'

module Ms
  module Data
    module_function
    
    # Initializes a new transposed data array.
    def new_transposed(unresolved_data)
      Transposed.new(unresolved_data)
    end
    
    # A Transposed data array lazily evaluates it's unresolved data as 
    # a transposed array.  The unresolved data is evaluated 
    # into an array using to_a.
    # 
    #   t = Ms::Data::Transposed.new([[1,4],[2,5],[3,6]])
    # 
    #   t.unresolved_data  # => [[1,4],[2,5],[3,6]]
    #   t.data             # => []
    #   t[0]               # => [1,2,3]
    #   t[1]               # => [4,5,6]
    #   t.data             # => [[1,2,3], [4,5,6]]
    #
    class Transposed < Simple
      
      def [](index)
        resolve.data[index]
      end
      
      def resolved?
        !@data.empty?
      end
      
      def resolve
        @data = @unresolved_data.to_a.transpose unless resolved?
        self
      end
      
    end
  end
end