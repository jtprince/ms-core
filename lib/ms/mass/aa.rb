require 'yaml'

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
    # molecules is built on constants and constants on ruby-units and it seems
    # impossible to get ruby-units 1.9 compatible.  Until that point, values
    # will remain hard coded and these values are free of dependencies.
    #
    # The values are built using the excellent {'molecules'
    # library}[http://github.com/bahuvrihi/molecules/tree/master].  See that
    # library for more serious work with masses.
    module AA

      yaml = <<-END
        --- 
        avg: 
          "*": 118.88603
          A: 71.0779
          B: 172.1405
          C: 103.1429
          D: 115.0874
          E: 129.11398
          F: 147.17386
          G: 57.05132
          H: 137.13928
          I: 113.15764
          K: 128.17228
          L: 113.15764
          M: 131.19606
          N: 114.10264
          O: 211.28076
          P: 97.11518
          Q: 128.12922
          R: 156.18568
          S: 87.0773
          T: 101.10388
          U: 150.0379
          V: 99.13106
          W: 186.2099
          X: 118.88603
          Y: 163.17326
          Z: 128.6231
        mono: 
          "*": 118.805716
          A: 71.0371137878
          B: 172.048405
          C: 103.0091844778
          D: 115.026943032
          E: 129.0425930962
          F: 147.0684139162
          G: 57.0214637236
          H: 137.0589118624
          I: 113.0840639804
          K: 128.0949630177
          L: 113.0840639804
          M: 131.0404846062
          N: 114.0429274472
          O: 211.1446528645
          P: 97.052763852
          Q: 128.0585775114
          R: 156.1011110281
          S: 87.0320284099
          T: 101.0476784741
          U: 150.9536355878
          V: 99.0684139162
          W: 186.0793129535
          X: 118.805716
          Y: 163.0633285383
          Z: 128.550585
      END

    
      embedded_mass_hashes = YAML.load(yaml)
      # amino_acids keys as strings, monoisotopic masses
      MONO_STRING = embedded_mass_hashes['mono']
      # amino_acids keys as symbols, monoisotopic masses
      MONO_SYM = Hash[MONO_STRING.map {|aa,mass| [aa.to_sym, mass] } ]

      # amino_acids keys as strings, average masses
      AVG_STRING = embedded_mass_hashes['avg']
      # amino_acids keys as symbols, average masses
      AVG_SYM = Hash[AVG_STRING.map {|aa,mass| [aa.to_sym, mass] } ]

      # amino_acids keys as symbols and also strings, monoisotopic masses
      MONO = MONO_SYM.merge(MONO_STRING)
      # amino_acids keys as symbols and also strings, average masses
      AVG = AVG_SYM.merge(AVG_STRING)

      ###########################################################################
      # This section is broken in 1.9 (ruby-units fault), so we generate the
      # data and include it.
      ###########################################################################

=begin
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
        require 'molecules'
        hash = {}
        ('A'..'Z').each do |letter|
          if res = Molecules::Libraries::Residue[letter]
            hash[letter.to_sym] =
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

      # Returns mono and avg tables as yaml with all keys as strings.
      # The top level keys are 'avg' and 'mono'
      def self.indices_to_yaml
        # this only works with ruby1.8 currently, so we use it to generate the
        # data we need
        require 'molecules'
        [AVG, MONO].each do |hash|
          hash.each {|k,v| hash[k.to_s] = hash.delete(k) }
        end
        {'avg' => AVG, 'mono' => MONO}.to_yaml
      end

      MONO = MOLECULES_MONO_UNSUPPORTED.merge( self.mass_index(:mono) )
      AVG = MOLECULES_AVG_UNSUPPORTED.merge( self.mass_index(:avg) )

      # the script to sort it nicely using ruby 1.9:
      require 'yaml'
      h = YAML.load_file(ARGV.shift)
      new_hash = {}
      h.sort.each do |key, aahash|
        new_hash[key] = Hash[aahash.sort]
      end
      puts new_hash.to_yaml

=end

      ###########################################################################
      # End fudge
      ###########################################################################

    end
  end
end


