require 'ms/fasta/archive'

module Ms
  module Fasta
    VERSION = '0.2.3'

    def self.new(*args, &block)
      Ms::Fasta::Archive.new(*args, &block).reindex
    end

    def self.open(*args, &block)
      Ms::Fasta::Archive.open(*args, &block)
    end

    def self.foreach(*args, &block)
      Ms::Fasta::Archive.open(*args) do |fasta|
        fasta.each(&block)
      end
    end
  end
end
