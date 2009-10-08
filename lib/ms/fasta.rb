require 'ms/fasta/archive'

module Ms
  module Fasta
    VERSION = '0.2.4'

    #def self.open(filename, &block)
      #Ms::Fasta::Archive.open(filename, 'rb', [], &block)
    #end
    def self.open(*args, &block)
      Ms::Fasta::Archive.open(*args, &block)
    end


    # returns :ipi, :ncbi, or nil if can't be determined
    def self.filetype(file_or_io)
      ft = nil
      io = 
        if file_or_io.is_a?(String)
          File.open(file_or_io)
        else
          init_pos = file_or_io.pos
          file_or_io.rewind
          file_or_io
        end
      io.each_line do |line|
        if line =~ /^>/
          ft = header_to_filetype(line[1..-1])
          break
        end
      end

      if file_or_io.is_a?(String)
        io.close
      else
        io.pos = init_pos
      end
      ft
    end

    # takes the header line (no leading >) and returns the kind of file
    def self.header_to_filetype(line)
      if line =~ /^IPI\:/
        :ipi
      elsif line =~ /^gi\|/
        :ncbi
      else
        nil
      end
    end

    # kind is :ipi or :ncbi or a String (the header)
    # gives the regular expression for parsing the header (no leading >)
    def self.id_regexp(kind)
      sym = 
        if kind.is_a?(String)
          header_to_filetype(kind)
        else ; kind
        end
      case sym
      when :ipi
        /^IPI:(.*?)\|/o
      when :ncbi
        /^gi\|(.*?)\|/o
      else
        nil
      end
    end
  end
end

