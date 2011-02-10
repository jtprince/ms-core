
module Cv
  class Description < Array
    def to_xml(xml)
      each {|param| param.to_xml(xml) }
    end
  end
end
