# frozen_string_literal: true

module Nmax
  module StreamReader
    def self.build(options)
      Object.const_get("Nmax::StreamReader::#{options[:parser]}").new(options)
    end
  end
  StreamReader.autoload(:ByChunk, "#{Nmax::NMAXDIR}/stream_reader/by_chunk")
  StreamReader.autoload(:ByLine, "#{Nmax::NMAXDIR}/stream_reader/by_line")
end
