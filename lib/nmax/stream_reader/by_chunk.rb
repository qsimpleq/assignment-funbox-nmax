# frozen_string_literal: true

module Nmax
  module StreamReader
    class ByChunk
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def run(&block)
        @options[:stream].each(options[:number_max_length]) { |chunk| block.call(chunk) }
      end
    end
  end
end
