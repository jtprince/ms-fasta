
module Ms
  module Fasta
    module Ipi
      IPI_RE = /IPI:([\w\.]+)\|/o
      class << self
        # returns a hash of header information where the values are all
        # strings (does NOT attempt to separate on ';'). The gene description
        # is held in the key 'description'
        def parse(header)
          gap_index = header.index(' ')
          hash = {}
          header[0...gap_index].split('|').each do |str|
            (key, val) = str.split(':')
            hash[key] = val
          end
          pieces = header[gap_index..-1].split(' ')
          hash.store(*pieces.shift.split('='))
          hash.store(*pieces.shift.split('='))
          hash.store('description', pieces.join(' '))
          hash
        end

        # returns the ipi index for the header (.e.g, ipi0000093.1)
        def ipi(header)
          IPI_RE.match(header)[1]
        end
      end
    end
  end
end
