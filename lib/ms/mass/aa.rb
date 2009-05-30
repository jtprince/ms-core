require 'molecules'
require 'ms/mass'

module Ms
  module Mass

    # A module for working with commonly used residue masses in proteomics.
    #
    #     require 'ms/mass/aa'
    #     include Ms::Mass::AA
    #
    #     MONO['A'] # => 71.0371137878
    #     AVG['A']  # => 71.0779
    #
    #     # or use symbols
    #     MONO[:A]  # => 71.0371137878
    #
    # This module is built on the excellent {'molecules'
    # library}[http://github.com/bahuvrihi/molecules/tree/master].  See that
    # library for more serious work with masses.
    module AA
      # These are included here to offer maximum functionality
      MOLECULES_MONO_UNSUPPORTED = {
        :B => 172.048405, # average of aspartic acid and asparagine
        :X => 118.805716,  # the average of the mono masses of the 20 amino acids
        :* => 118.805716, # same as X
        :Z => (129.04259 + 128.05858) / 2,  # average glutamic acid and glutamine
        #:J => nil,
      }
      MOLECULES_AVG_UNSUPPORTED = {
        :B => 172.1405, # average of aspartic acid and asparagine
        :X => 118.88603, # the average of the masses of the 20 amino acids
        :* => 118.88603, # same as X
        :Z => (129.1155+ 128.1307) / 2,  # average glutamic acid and glutamine
        #:J => nil,
      }


      # returns a hash based on the molecules library of amino acid residues.
      # type is :mono or :avg
      def self.mass_index(type=:mono)
        hash = {}
        ('A'..'Z').each do |letter|
          if res = Molecules::Libraries::Residue[letter]
            hash[letter] =
              if type == :mono
                res.mass
              elsif type == :avg
                res.mass {|v| v.std_atomic_weight.value }
              else
                raise ArgumentError, "type must be :mono or :avg"
              end
          end
        end
        hash
      end

      MONO = MOLECULES_MONO_UNSUPPORTED.merge( self.mass_index(:mono) )
      AVG = MOLECULES_AVG_UNSUPPORTED.merge( self.mass_index(:avg) )
      [AVG, MONO].each do |hash|
        hash.each {|k,v| hash[k.to_s] = v }
      end

    end
  end
end

