require 'ms/fasta/archive'

module Ms
  module Random
    # :startdoc::task selects n random fasta entries
    #
    # Selects random fasta entries from a fasta file. Entries are returned as
    # an array, and by default as Ms::Fasta::Entry objects.
    #
    class Fasta < Tap::Task
  
      config :n, 1, &c.integer           # the number of fasta to select
      config :fasta, false, &c.switch    # returns entries as fasta strings
      config :distinct, true, &c.switch  # requires entries to be unique by sequence
    
      def process(fasta_file)
        entries = []
      
        log :index, fasta_file unless File.exist?("#{fasta_file}.index")
        Ms::Fasta::Archive.open(fasta_file) do |archive|
          total_entries = archive.length
          log :select, "#{n} entries"
        
          # pick entries, filtering by sequence
          while entries.length < n
            entry = archive[rand(total_entries)]
            next if distinct && entries.find {|existing| existing.sequence == entry.sequence }
          
            entries << entry
          end
        end
      
        entries.collect! do |entry|
          entry.to_s
        end if fasta
      
        entries
      end
    end
  end 
end