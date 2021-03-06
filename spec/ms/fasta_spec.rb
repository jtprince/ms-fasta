require File.dirname(__FILE__) + '/../spec_helper'

require 'ms/fasta'

describe 'basic fasta operations' do

  before do
    @headers = [">gi|5524211 [hello]", ">another B", ">again C"]
    @entries = ["LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV\nGLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX\nIENY", "ABCDEF\nGHIJK", "ABCD"]
    @sequences = @entries.map {|v| v.gsub("\n", '') }
    @data = {}
    @data['newlines'] = @headers.zip(@entries).map do |header, data|
      header + "\n" + data
    end.join("\n")
    @data['carriage_returns_and_newlines'] = @data['newlines'].gsub("\n", "\r\n")
    @files = {}
    @data.each do |k,v|
      file_key = k + '_file'
      filename = k + '.tmp'
      @files[file_key] = filename
      File.open(filename, 'w') {|out| out.print v }
    end
  end

  after do
    @files.select {|k,v| k =~ /_file$/ }.each do |k,filename|
      index = filename.sub('.tmp', '.index')
      [filename, index].each do |fn|
        File.unlink(fn) if File.exist? fn
      end
    end
  end

  def fasta_correct?(fasta)
    fasta.size.is 3
    (0...@headers.size).each do |i|
      header, sequence, entry = @headers[i], @sequences[i], fasta[i]
      entry.header.isnt nil
      entry.sequence.isnt nil
      entry.header.is header[1..-1]
      entry.sequence.is sequence
    end
  end

  it 'can read a file' do
    %w(newlines_file carriage_returns_and_newlines_file).each do |file|
      Ms::Fasta.open(@files[file]) do |fasta|
        fasta_correct? fasta
      end
    end
  end

  it 'can read an IO object' do
    %w(newlines_file carriage_returns_and_newlines_file).each do |file|
      File.open(@files[file]) do |io|
        fasta = Ms::Fasta.new(io)
        fasta_correct? fasta
      end
    end
  end

  it 'can read a string' do
    %w(newlines carriage_returns_and_newlines).each do |key|
      fasta = Ms::Fasta.new @data[key]
      fasta_correct? fasta
    end
  end

  it 'iterates entries with foreach' do
    %w(newlines_file carriage_returns_and_newlines_file).each do |file|
      Ms::Fasta.foreach(@files[file]) do |entry|
        entry.isa Ms::Fasta::Entry 
      end
    end
  end

end
