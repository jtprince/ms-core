
module Ms ; end
module Ms::Id ; end

module Ms::Id::Protein
  
  class << self
  end

  # gives the information up until the first space or carriage return.
  # Assumes the protein can respond_to? :reference
  def first_entry
    reference.split(/[\s\r]/)[0]
  end

end

