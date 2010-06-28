require File.join(File.dirname(__FILE__), '../../spec_helper.rb') 

require 'ms/fasta'
require 'ms/fasta/header'

shared 'determining filetype based on the header' do

  before do
    @header_lines = {
      :ipi => ['IPI:IPI00000005.1|SWISS-PROT:P01111|TREMBL:Q5U091|ENSEMBL:ENSP00000358548;ENSP00000385392|REFSEQ:NP_002515|VEGA:OTTHUMP00000013879 Tax_Id=9606 Gene_Symbol=NRAS GTPase NRas'],
      :uniprot => ['sp|P31946|1433B_HUMAN 14-3-3 protein beta/alpha OS=Homo sapiens GN=YWHAB PE=1 SV=3', 'tr|D3DSH8|D3DSH8_HUMAN HCG2036819, isoform CRA_a OS=Homo sapiens GN=hCG_2036819 PE=4 SV=1'],
      :ncbi => ['gi|16127999|ref|NP_414546.1| hypothetical protein b0005 [Escherichia coli K12]'],
    }
  end

  xit 'can return the filetype given a file or io object' do
    # need to write this
  end

  it 'returns a filetype or nil given a header line' do
    @header_lines.each do |k,array|
      array.each do |v|
        @klass.header_to_filetype(v).is k
      end
    end
  end

  it 'returns a regular expression that retrieves the ID from a header' do
    # A basic example:
    header = "tr|D3DSH8|D3DSH8_HUMAN HCG2036819, iso ..."
    regexp1 = @klass.id_regexp(:uniprot)
    regexp2 = @klass.id_regexp(header)
    regexp1.is regexp2
    header.match(regexp1)[1].is "D3DSH8"

    # exhaustively test:
    {:ipi => %w(IPI00000005.1), :uniprot => %w(P31946 D3DSH8), :ncbi => %w(16127999)}.each do |symbol,v|
      @header_lines[symbol].each do |header|
        to_equal = v.shift
        # takes either a header line (no >)
        [symbol, header].each do |query|
          regexp = @klass.id_regexp(query)
          header.match(regexp)[1].is to_equal
        end
      end
    end
  end

end

describe 'Ms::Fasta::Header' do
  before do
    @klass = Ms::Fasta::Header
  end
  behaves_like 'determining filetype based on the header'
end

describe 'Ms::Fasta' do
  before do
    @klass = Ms::Fasta
  end
  behaves_like 'determining filetype based on the header'
end
