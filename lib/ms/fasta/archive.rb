require 'external'
require 'ms/fasta/entry'

module Ms
  module Fasta
    # Provides access to a FASTA file as an ExternalArchive.
    class Archive < ExternalArchive

      # Reindexes self to each FASTA entry in io
      def reindex(&block)
        reindex_by_sep(nil, :sep_regexp => /\n>/, :sep_length => 1, :entry_follows_sep => true, &block)
      end

      # Returns a Fasta::Entry initialized using str
      def str_to_entry(str)
        Entry.parse(str)
      end

    end
  end
end