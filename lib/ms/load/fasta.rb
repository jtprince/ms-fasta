require 'tap/tasks/load'
require 'ms/fasta/entry'

module Ms
  module Load
    # :startdoc::task loads entries in a fasta file
    #
    # Loads entries from a fasta file.
    #
    class Fasta < Tap::Tasks::Load
      Entry = Ms::Fasta::Entry
      
      config :header, true, &c.switch
      config :sequence, true, &c.switch
      
      def entry_break?(io)
        if c = io.getc
          io.ungetc(c)
          c == ?>
        else
          true
        end
      end
      
      def load(io)
        header = io.readline
        sequence = []
        while !entry_break?(io)
          sequence << io.readline
        end
        
        case
        when !self.header
          sequence.join('')
        when !self.sequence
          header
        else
          "#{header}#{sequence.join('')}"
        end
      end
      
    end 
  end
end