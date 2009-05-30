require 'tap/tasks/load'
require 'ms/fasta/entry'

module Ms
  module Load
    # :startdoc::task loads entries in a fasta file
    #
    # Loads entries from a fasta file.  Entries are converted to
    # Ms::Fasta::Entry objects unless the fasta config is specified.
    #
    class Fasta < Tap::Tasks::Load
      Entry = Ms::Fasta::Entry
      
      config :fasta, false, &c.switch         # returns entries as fasta strings
      
      def load(io)
        str = io.readline(">")
        if str == ">"
          str = io.readline(">")
        end
        
        if fasta
          ">#{str.chomp('>')}"
        else
          lines = str.split(/\r?\n/)
          lines.pop if lines[-1] == ">"
          
          Entry.new(lines.shift, lines.join(''))
        end
      end
      
      def complete?(io, last)
        io.pos == io.stat.size
      end
      
    end 
  end
end