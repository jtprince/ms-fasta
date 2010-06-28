require 'ms/fasta/archive'
require 'ms/fasta/header'

module Ms
  module Fasta
    def self.new(*args, &block)
      Ms::Fasta::Archive.new(*args, &block).reindex
    end

    #def self.open(filename, &block)
      #Ms::Fasta::Archive.open(filename, 'rb', [], &block)
    #end

    def self.open(*args, &block)
      Ms::Fasta::Archive.open(*args, &block)
    end

    def self.foreach(*args, &block)
      Ms::Fasta::Archive.open(*args) do |fasta|
        fasta.each(&block)
      end
    end

    extend Ms::Fasta::Header
  end
end

