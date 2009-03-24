require 'ms/fasta/archive'

module Ms
  module Fasta
    # Ms::Fasta::Load::manifest loads entries in a fasta file
    #
    # Loads entries in a fasta file as an array of Ms::Fasta::Entry objects.
    class Load < Tap::Task
      
      def process(fasta_file)
        Archive.open(fasta_file) do |archive|
          return archive.to_a
        end
      end
    end 
  end
end