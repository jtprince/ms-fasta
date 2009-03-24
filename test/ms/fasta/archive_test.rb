require File.join(File.dirname(__FILE__), '../../tap_test_helper.rb') 
require 'ms/fasta/archive'

class FastaAchiveTest < Test::Unit::TestCase
  include Ms::Fasta
  
  FASTA_0 = %Q{>gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]
LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX
IENY
}

  FASTA_1 = %Q{>gi|1048576| protein sequence
PROTEIN
}

  def test_reindex
    strio = StringIO.new(FASTA_0 + FASTA_1)
    begin
      a = Archive.new(strio)
    
      assert_equal 0, a.length
      a.reindex
      assert_equal 2, a.length
    
      assert_equal FASTA_0, a[0].to_s
      assert_equal FASTA_1, a[1].to_s
      assert_equal "gi|1048576| protein sequence", a[1].header
    ensure
      a.close
    end
  end
  
  def test_str_to_entry
    begin
      a = Archive.new
      e = a.str_to_entry(FASTA_0)
      
      assert_equal Entry, e.class
      assert_equal "gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]", e.header
      assert_equal(
      "LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV" + 
      "GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX" +
      "IENY", e.sequence)
    ensure
      a.close
    end
  end
end