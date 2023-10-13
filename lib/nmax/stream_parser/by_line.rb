# frozen_string_literal: true

require_relative 'helper'

module Nmax
  module StreamParser
    class ByLine
      include Nmax::StreamParser::Helper

      attr_reader :options

      REGEXP_ONLY_NUMBERS_SPACES = Regexp.new('[^0-9\s]+')
      REGEXP_MULTISPACES = Regexp.new('\s+')

      def initialize(options)
        @options = options
      end

      def parse(line)
        data = split(line)
        return if data.empty?

        @options[:min] ||= data[0]
        @options[:max] ||= data[0]

        processing(data)
        storage_cleaning
      end

      private

      def split(line)
        line
          .strip
          .gsub(REGEXP_ONLY_NUMBERS_SPACES, ' ')
          .gsub(REGEXP_MULTISPACES, ' ')
          .split(' ')
          .reject { _1.length > options[:number_max_length] }
          .map(&:to_i) || []
      end

      def processing(data)
        data.each do |num|
          if @options[:storage].keys.size >= options[:numbers_limit]
            next if num < @options[:min]

            if num > @options[:max]
              @options[:storage].delete(@options[:min])
              @options[:min] = @options[:storage].keys.min
            end
          end

          @options[:min] = num if @options[:min] > num
          @options[:max] = num if @options[:max] < num

          @options[:storage][num] = 0 unless @options[:storage].key?(num)
          @options[:storage][num] += 1
        end
      end
    end
  end
end
