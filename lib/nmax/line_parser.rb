# frozen_string_literal: true

module Nmax
  class LineParser
    attr_reader :options

    REGEXP_ONLY_NUMBERS_SPACES = Regexp.new('[^0-9\s]+')
    REGEXP_MULTISPACES = Regexp.new('\s+')

    def initialize(options)
      @options = options
    end

    def parse(line)
      line
        .strip
        .gsub(REGEXP_ONLY_NUMBERS_SPACES, ' ')
        .gsub(REGEXP_MULTISPACES, ' ')
        .split(' ')
        .reject { _1.length > options[:number_max_length] }
        .map(&:to_i) || []
    end
  end
end
