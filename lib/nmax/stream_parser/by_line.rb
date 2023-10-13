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

      def run(line)
        data = split(line)
        return if data.empty?

        parse(data)
        storage_cleaning
      end

      private

      def split(line)
        line
          .strip
          .gsub(REGEXP_ONLY_NUMBERS_SPACES, ' ')
          .gsub(REGEXP_MULTISPACES, ' ')
          .split(' ')
          .reject { |e| e.length > options[:number_max_length] }
          .map(&:to_i) || []
      end

      def parse(data)
        data.each do |current_number|
          next if ignore_too_small_number?(current_number)

          recalc_storage_if_new_max_find(current_number)
          recalc_min_max(current_number)
          storage_add(current_number)
        end
      end

      def ignore_too_small_number?(current_number)
        if !@options[:min].nil? && \
           current_number < @options[:min] && \
           @options[:storage].keys.size >= @options[:numbers_limit]
          true
        end
      end
    end
  end
end
