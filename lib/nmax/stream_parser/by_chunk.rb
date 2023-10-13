# frozen_string_literal: true

require_relative 'helper'

module Nmax
  module StreamParser
    class ByChunk
      include Nmax::StreamParser::Helper

      attr_reader :options, :current_number, :state

      NUMBERS = {
        '0' => 0,
        '1' => 1,
        '2' => 2,
        '3' => 3,
        '4' => 4,
        '5' => 5,
        '6' => 6,
        '7' => 7,
        '8' => 8,
        '9' => 9
      }.freeze

      def initialize(options)
        @options = options
      end

      def run(chunk)
        chunk.each_char do |char|
          if @current_number.nil? && numeric?(char)
            @current_number = char
          elsif numeric?(char)
            @current_number += char
            add_number if @options[:stream].eof?
          else
            add_number
          end
        end

        storage_cleaning
      end

      private

      def numeric?(char)
        NUMBERS.key?(char)
      end

      def add_number
        return if @current_number.nil? || discard_too_long_number?

        current_number = @current_number.to_i
        return if ignore_too_small_number?(current_number)

        recalc_storage_if_new_max_find(current_number)
        recalc_min_max(current_number)

        @options[:storage][current_number] = 0 unless @options[:storage].key?(current_number)
        @options[:storage][current_number] += 1
        @current_number = nil

        current_number
      end

      def discard_too_long_number?
        return if @current_number.size <= @options[:number_max_length]

        @current_number = nil

        true
      end

      def ignore_too_small_number?(current_number)
        if !@options[:min].nil? && \
           current_number < @options[:min] && \
           @options[:storage].keys.size >= @options[:numbers_limit]
          @current_number = nil

          true
        end
      end

      def recalc_storage_if_new_max_find(current_number)
        return if @options[:storage].keys.size < options[:numbers_limit]
        return if current_number <= @options[:max]

        if @options[:storage][@options[:min]] > 1
          @options[:storage][@options[:min]] -= 1
        else
          @options[:storage].delete(@options[:min])
          @options[:min] = @options[:storage].keys.min
        end
      end

      def recalc_min_max(current_number)
        @options[:min] = current_number if @options[:min].nil? || @options[:min] > current_number
        @options[:max] = current_number if @options[:max].nil? || @options[:max] < current_number
      end
    end
  end
end
