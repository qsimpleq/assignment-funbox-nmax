# frozen_string_literal: true

module Nmax
  module StreamReader
    class ByChunk
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def run(&block)
        block.call(@options[:stream].readchar) until @options[:stream].eof?
      end
    end
  end
end
