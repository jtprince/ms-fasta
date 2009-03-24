module Ms
  module Fasta

    # Entry represents a FASTA formatted entry. 
    #
    #   entry = Entry.parse %q{
    #   >gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]
    #   LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
    #   EWIWGGFSVDKATLNRFFAFHFILPFTMVALAGVHLTFLHETGSNNPLGLTSDSDKIPFHPYYTIKDFLG
    #   LLILILLLLLLALLSPDMLGDPDNHMPADPLNTPLHIKPEWYFLFAYAILRSVPNKLGGVLALFLSIVIL
    #   GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX
    #   IENY
    #   }.strip
    #
    #   entry.header[0,30]       # => 'gi|5524211|gb|AAD44166.1| cyto'
    #   entry.sequence[0,30]     # => 'LCLYTHIGRNIYYGSYLYSETWNTGIMLLL'
    #
    class Entry
      class << self

        # Parses the entry string into a Fasta::Entry.  The entry string must
        # be well-formatted, ie begin with '>'.
        def parse(str)
          unless str[0] == ?>
            raise "input should begin with '>'"
          end

          seq_begin = str.index("\n")
          Entry.new(str[1, seq_begin-1], str[seq_begin, str.length - seq_begin].gsub(/\r?\n/, ""))
        end
      end
      
      # The header for self
      attr_accessor :header
      
      # The sequence of self
      attr_accessor :sequence

      def initialize(header="", sequence="")
        @header = header
        @sequence = sequence
      end

      # Returns the header and sequence formated into lines of line_length
      # or less.  The '>' delimiter is added to the header line.
      def lines(line_length=70)
        raise ArgumentError.new("line length must be greater than 0") unless line_length > 0

        lines = [">#{header}"]
        current = 0
        while current < sequence.length
          lines << sequence[current, line_length]
          current += line_length
        end

        lines
      end

      # Formats and dumps self to the target.  Use the options to modify the output:
      #
      # line_length:: the length of each output line (default 70)
      def dump(target="", options={})
        line_length = options.has_key?(:line_length) ? options[:line_length ] : 70
        target << self.lines(line_length).join("\n")
        target << "\n"
        target
      end

      # Returns self formatted as a string
      def to_s
        dump
      end
    end
  end
end