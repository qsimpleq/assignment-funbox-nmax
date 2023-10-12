# frozen_string_literal: true

module Nmax
  module StreamReader
    class ByLine
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def run(&block)
        @options[:stream].each_line(&block)
      end
    end
  end
end
