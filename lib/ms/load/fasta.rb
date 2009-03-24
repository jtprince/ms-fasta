require 'ms/fasta/archive'

module Ms
  module Load
    # :startdoc::manifest loads entries in a fasta file
    #
    # Loads entries from a fasta file.  Entries are returned as an array and
    # by default as Ms::Fasta::Entry objects.
    #
    class Fasta < Tap::Task
      
      config :range, 0..10, &c.range     # the range of entries to select
      config :fasta, false, &c.switch    # returns entries as fasta strings
        
      def process(fasta_file)
        Ms::Fasta::Archive.open(fasta_file) do |archive|
          entries = archive[range]
          
          # totally wasteful... ExternalArchive needs
          # a way to read a selection of string without
          # conversion to entries.
          # watch (http://bahuvrihi.lighthouseapp.com/projects/10590-external/tickets/7-for-strings)
          entries.collect! {|entry| entry.to_s } if fasta
          entries
        end
      end
    end 
  end
end