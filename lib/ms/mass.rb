
module Ms
  module Mass
    MASCOT_H_PLUS = 1.007276
    H_PLUS = 1.00727646677  # need to verify this against HYDROGEN - ELECTRON
    PROTON = H_PLUS

    # lower case elements (h = Hydrogen)
    MONO_STRING = {
      'h+' => 1.00727646677,
      'h' => 1.007825035,
      'h2o' => 18.0105647,
      'oh' => 17.002739665,
    }
    MONO_SYM = Hash[ MONO_STRING.map {|k,v| [k.to_sym, v] } ]
    MONO = MONO_STRING.merge(MONO_SYM)

    # lower case elements (h = Hydrogen)
    AVG_STRING = {
      'h+' => 1.007276, # using Mascot_H_plus mass (is this right for AVG??)
      'h' => 1.00794,
      'h2o' => 18.01528, 
      'oh' => 17.00734,
    }
    AVG_SYM = Hash[ AVG_STRING.map {|k,v| [k.to_sym, v] } ]
    AVG = AVG_STRING.merge(AVG_SYM)

  end
end

