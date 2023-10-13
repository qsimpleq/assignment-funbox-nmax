# frozen_string_literal: true

module Nmax
  module StreamParser
    def self.build(options)
      Object.const_get("Nmax::StreamParser::#{options[:parser]}").new(options)
    end
  end
  StreamParser.autoload(:ByChunk, "#{Nmax::NMAXDIR}/stream_parser/by_chunk")
  StreamParser.autoload(:ByLine, "#{Nmax::NMAXDIR}/stream_parser/by_line")
end
