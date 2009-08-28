module Ms
  module Data
    
    # LazyIO represents data to be lazily read from an IO.  To read the data
    # from the IO, either string or to_a may be called (to_a unpacks the 
    # string into an array using the decode_format and unpack_format).
    #
    # LazyIO is a suitable unresolved_data source for Ms::Data formats.
    class LazyIO
      NETWORK_FLOAT = 'g*'
      NETWORK_DOUBLE = 'G*'
      LITTLE_ENDIAN_FLOAT = 'e*'
      LITTLE_ENDIAN_DOUBLE = 'E*'
      BASE_64 = 'm'
      
      class << self
        # Returns the unpacking code for the given precision (32 or 64-bit)
        # and network order (true for big-endian).
        def unpack_code(precision, network_order)
          case precision
          when 32 then network_order ? NETWORK_FLOAT : LITTLE_ENDIAN_FLOAT
          when 64 then network_order ? NETWORK_DOUBLE : LITTLE_ENDIAN_DOUBLE
          else raise ArgumentError, "unknown precision (should be 32 or 64): #{precision}"
          end
        end
      end
    
      # The IO from which string is read
      attr_reader :io
      
      # The start index for reading string
      attr_reader :start_index
      
      # The number of bytes to be read from io when evaluating string
      attr_reader :num_bytes
      
      # Indicates the unpacking format
      attr_reader :unpack_format
      
      # Indicates a decoding format, may be false to unpack string
      # without decoding.
      attr_reader :decode_format
      
      def initialize(io, start_index=io.pos, num_bytes=nil, unpack_format=NETWORK_FLOAT, decode_format=BASE_64)
        @io = io
        @start_index = start_index
        @num_bytes = num_bytes
        @unpack_format = unpack_format
        @decode_format = decode_format
      end
      
      # Positions io at start_index and reads a string of num_bytes length.
      # The string is newly read from io each time string is called.
      def string
        io.pos = start_index unless io.pos == start_index
        io.read(num_bytes)
      end
      
      # Resets the cached array (returned by to_a) so that the array will
      # be re-read from io.
      def reset
        @array = nil
      end
      
      # Reads string and unpacks using decode_format and unpack_code.  The
      # array is cached internally; to re-read the array, use reset.
      def to_a
        @array ||= (decode_format ? string.unpack(decode_format)[0] : string).unpack(unpack_format)
      end

    end
  end
end
