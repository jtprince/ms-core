
module Ms
  module Id

    module Search
      attr_accessor :prots
      attr_accessor :peps

      def protein_class
        self.const_get("Prot")
      end


      # returns an array of peptide_hits and protein_hits that are linked to
      # one another.  NOTE: this will update peptide and protein
      # hits :prots and :peps attributes respectively).  Assumes that each search
      # responds to :peps, each peptide responds to :prots and each protein to
      # :peps.  Can be done on a single file to restore protein/peptide
      # linkages to their original single-file state.
      # Assumes the protein is initialized with (reference, peptide_ar)
      #
      # yields the protein that will become the template for a new protein
      # and expects a new protein hit
      def merge!(ar_of_peptide_hit_arrays)
        all_peptide_hits = []
        reference_hash = {}
        ar_of_peptide_hit_arrays.each do |peptide_hits|
          all_peptide_hits.push(*peptide_hits)
          peptide_hits.each do |pep|
            pep.prots.each do |prot|
              ref = prot.reference
              if reference_hash.key? ref
                reference_hash[ref].peps << pep
                reference_hash[ref]
              else
                reference_hash[ref] = yield(prot, [pep])
              end
            end
          end
        end
        [all_peptide_hits, reference_hash.values]
      end

    end


    module SearchGroup 
      include Search

      # an array of search objects
      attr_accessor :searches
      
      # the group's file extension (with no leading period)
      def extension
        'grp'
      end

      def search_class
        Search
      end

      # a simple formatted file with paths to the search files
      def to_paths(file)
        IO.readlines(file).grep(/\w/).reject {|v| v =~ /^#/}.map {|v| v.chomp }
      end

      def from_file(file)
        from_filenames(to_paths(file))
      end


      def from_filenames(filenames)
        filenames.each do |file|
          if !File.exist? file
            message = "File: #{file} does not exist!\n"
            message << "perhaps you need to modify the file with file paths"
            abort message
          end
          @searches << search_class.new(file)
        end
      end


      # takes an array of filenames or a single search filename (with
      # extension defined by 'extendsion') or an array of objects passes any
      # arguments to the initializer for each search
      # the optional block yields the object for further processing
      def initialize(arg=nil, opts={})
        @peps = []
        @reference_hash = {}
        @searches = []

        if arg
          if arg.is_a?(String) && arg =~ /\.#{Regexp.escap(extension)}$/
            from_file(arg)
          elsif arg.is_a?(Array) && arg.first.is_a?(String)
            from_filenames(arg)
          elsif arg.is_a?(Array)
            @searches = array
          else
            raise ArgumentError, "must be file, array of filenames, or array of objs"
          end
          @searches << search_class.new(file, opts)
        end
        yield(self) if block_given?
      end

    end
  end
end
