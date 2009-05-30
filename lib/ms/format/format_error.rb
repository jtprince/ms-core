module Ms
  module Format
    class FormatError < Exception
      attr_accessor :str
      
      def initialize(msg, str)
        super(msg)
        @str = str
      end
    end
  end
end