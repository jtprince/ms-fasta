require File.join(File.dirname(__FILE__), '../../spec_helper.rb') 
require 'ms/fasta/entry'

class FastaEntryTest
  include Ms::Fasta
  
  describe 'basic Entry operations' do
    # Abbreviated FASTA entry from wikipedia (http://en.wikipedia.org/wiki/FASTA_format)
    FASTA_0 = %Q{>gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]
LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX
IENY
}

    #
    # documentation test
    #

    it 'parses an entry as per docs' do
      entry = Entry.parse %q{
>gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]
LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
EWIWGGFSVDKATLNRFFAFHFILPFTMVALAGVHLTFLHETGSNNPLGLTSDSDKIPFHPYYTIKDFLG
LLILILLLLLLALLSPDMLGDPDNHMPADPLNTPLHIKPEWYFLFAYAILRSVPNKLGGVLALFLSIVIL
GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX
IENY
}.strip

      entry.header[0,30].is 'gi|5524211|gb|AAD44166.1| cyto'
      entry.sequence[0,30].is 'LCLYTHIGRNIYYGSYLYSETWNTGIMLLL'
    end

    #
    # class parse tests 
    #

    it 'parses header and sequence' do
      e = Entry.parse(FASTA_0)
      e.header.is "gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]"
      e.sequence.is(
        "LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV" +
        "GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX" + "IENY")
    end

    it 'raises error for entries that do not start with gt' do
      
      lambda { Entry.parse "\n#{FASTA_0}" }.should.raise(RuntimeError).message.should.equal("input should begin with '>'")
    end

    #
    # initialize tests 
    #

    def test_entry_initialization
      e = Entry.new
      assert_equal("", e.header)
      assert_equal("", e.sequence)

      e = Entry.new "head", "SEQ"
      assert_equal("head", e.header)
      assert_equal("SEQ", e.sequence)
    end

    #
    # dump tests
    #

    def test_dump_formats_a_fasta_entry
      e = Entry.new
      assert_equal(">\n", e.dump)

      e = Entry.new "head", "SEQ"
      assert_equal(">head\nSEQ\n", e.dump)
    end

    def test_dump_formats_output_with_desired_line_length
      e = Entry.new "header", "ABCDEFGH"
      assert_equal(">header\nABC\nDEF\nGH\n", e.dump("", :line_length => 3))
    end

    def test_dump_line_length_less_than_1_raises_error
      e = Entry.new
      assert_raise(ArgumentError) { e.dump("", :line_length => 0) }
    end
  end
end
