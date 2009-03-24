require File.join(File.dirname(__FILE__), '../../tap_test_helper.rb') 
require 'ms/fasta/entry'

class FastaEntryTest < Test::Unit::TestCase
  include Ms::Fasta
  
  # Abbreviated FASTA entry from wikipedia (http://en.wikipedia.org/wiki/FASTA_format)
  FASTA_0 = %Q{>gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]
LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX
IENY
}

  #
  # class parse tests 
  #
  
  def test_parse
    e = Entry.parse(FASTA_0)
    assert_equal "gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]", e.header
    assert_equal(
    "LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV" + 
    "GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX" +
    "IENY", e.sequence)
  end
  
  def test_parse_raises_error_for_entries_that_do_not_start_with_gt
    e = assert_raises(RuntimeError) { Entry.parse "\n#{FASTA_0}" }
    assert_equal "input should begin with '>'", e.message
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