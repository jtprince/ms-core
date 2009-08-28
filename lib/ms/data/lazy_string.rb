require 'ms/data/lazy_io'
require 'stringio'

module Ms
  module Data
    
    # LazyString is a LazyIO initialized from a string, which is converted into
    # a StringIO.
    class LazyString < LazyIO
      def initialize(string, unpack_format=NETWORK_FLOAT, decode_format=BASE_64)
        super(StringIO.new(string), 0, string.length, unpack_format, decode_format)
      end
    end
  end
end