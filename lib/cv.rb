
# Controlled vocabulary
class CV
  attr_accessor :cv_ref, :accession, :name, :value

  def initialize(cv_ref, accession, name, value=nil)
   (@cv_ref, @accession, @name, @value) = [cv_ref, accession, name, value]
  end

  def to_xml(xml, name=:cvParam)
    hash_to_send = {:cvRef => @cvref, :accession => @accession, :name => @name}
    hash_to_send[:value] = @value if @value
    xml.send(name, hash_to_send)
  end
end

