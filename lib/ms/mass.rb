
module Ms
  module Mass
    MASCOT_H_PLUS = 1.007276
    H_PLUS = 1.00727646677  # need to verify this against HYDROGEN - ELECTRON
    PROTON = H_PLUS

    # lower case elements (h = Hydrogen)
    MONO = {
      'h+' => 1.00727646677,
      'h' => 1.007825035,
      'h2o' => 18.0105647,
      'oh' => 17.002739665,
    }
    # lower case elements (h = Hydrogen)
    AVG = {
      'h' => 1.00794,
      'h2o' => 18.01528, 
      'oh' => 17.00734,
    }
  end
end

