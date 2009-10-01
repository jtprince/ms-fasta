require File.dirname(__FILE__) + '/../../tap_test_helper'

require 'ms/fasta/ipi'

class IpiSpec < MiniTest::Spec
  include Ms::Fasta

  before do
    @headers = ['IPI:IPI00000001.2|SWISS-PROT:O95793-1|TREMBL:A8K622;Q59F99|ENSEMBL:ENSP00000360922;ENSP00000379466|REFSEQ:NP_059347|H-INV:HIT000329496|VEGA:OTTHUMP00000031233 Tax_Id=9606 Gene_Symbol=STAU1 Isoform Long of Double-stranded RNA-binding protein Staufen homolog 1',
'IPI:IPI00000005.1|SWISS-PROT:P01111|TREMBL:Q5U091|ENSEMBL:ENSP00000358548;ENSP00000385392|REFSEQ:NP_002515|VEGA:OTTHUMP00000013879 Tax_Id=9606 Gene_Symbol=NRAS GTPase NRas']

    @answers = [{"Gene_Symbol"=>"STAU1", "VEGA"=>"OTTHUMP00000031233", "IPI"=>"IPI00000001.2", "H-INV"=>"HIT000329496", "REFSEQ"=>"NP_059347", "Tax_Id"=>"9606", "SWISS-PROT"=>"O95793-1", "ENSEMBL"=>"ENSP00000360922;ENSP00000379466", "TREMBL"=>"A8K622;Q59F99", "description"=>"Isoform Long of Double-stranded RNA-binding protein Staufen homolog 1"},
{"Gene_Symbol"=>"NRAS", "VEGA"=>"OTTHUMP00000013879", "IPI"=>"IPI00000005.1", "REFSEQ"=>"NP_002515", "Tax_Id"=>"9606", "SWISS-PROT"=>"P01111", "ENSEMBL"=>"ENSP00000358548;ENSP00000385392", "TREMBL"=>"Q5U091", "description"=>"GTPase NRas"}]
  end

  it 'parses IPI headers' do
    # assumes that the leading '>' has been removed
    @headers.zip(@answers) do |header, answ|
      Ipi.parse(header).must_equal answ
    end
  end

  it 'can retrive the IPI ID' do
    answers = ["IPI00000001.2", "IPI00000005.1"]

    @headers.zip(answers) do |header, answ|
      Ipi.ipi(header).must_equal answ
    end
  end

end
