# frozen_string_literal: true

module Nmax
  module StreamReader
    class ByChunk
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def run(&block)
        while (char = @options[:stream].read(@options[:number_max_length]))
          block.call(char)
        end
      end
    end
  end
end
