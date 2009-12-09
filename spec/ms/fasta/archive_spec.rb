require File.join(File.dirname(__FILE__), '../../spec_helper.rb') 
require 'ms/fasta/archive'

class FastaAchiveSpec
  include Ms::Fasta

  describe 'fasta archive operations' do

    FASTA_0 = %Q{>gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]
LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX
IENY
}

    FASTA_1 = %Q{>gi|1048576| protein sequence
PROTEIN
}

    it 'reindexes' do
      strio = StringIO.new(FASTA_0 + FASTA_1)
      begin
        a = Archive.new(strio)

        a.length.is 0
        a.reindex
        a.length.is 2

        a[0].to_s.is FASTA_0
        a[1].to_s.is FASTA_1
        a[1].header.is "gi|1048576| protein sequence"
      ensure
        a.close
      end
    end

    it 'properly converts the fasta string to an entry object' do
      begin
        a = Archive.new
        e = a.str_to_entry(FASTA_0)

        e.isa Entry
        e.header.is "gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]"
        e.sequence.is("LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV" + "GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX" + "IENY")
      ensure
        a.close
      end
    end
  end
end
