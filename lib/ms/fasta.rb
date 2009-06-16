
module Ms
  module Fasta
    VERSION = '0.2.3'

    def self.new(*args, &block)
      Ms::Fasta::Archive.new(*args, &block).reindex
    end

    def self.open(*args, &block)
      Ms::Fasta::Archive.open(*args, &block)
    end

  end
end
