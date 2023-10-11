# frozen_string_literal: true

require_relative 'line_parser'

module Nmax
  class Runner
    attr_reader :options

    def initialize(options)
      @options = options_defaults(options)
    end

    def calculate(options = @options)
      storage = stream_parser(options)

      storage_to_result(storage) { |key, value| puts [key] * value }
    end

    private

    def options_defaults(options)
      options[:numbers_limit] ||= 10
      options[:number_max_length] ||= 2
      options
    end

    def storage_to_result(storage)
      storage.keys.sort { |a, b| b <=> a }.each do |key|
        yield key, storage[key]
      end
    end

    def stream_parser(options)
      parser = LineParser.new(options)
      stream = options[:stream]
      storage = {}
      min = nil
      max = nil

      stream.each_line do |line|
        data = parser.parse(line)
        next if data.empty?

        min ||= data[0]
        max ||= data[0]

        data.each do |num|
          if storage.keys.size >= options[:numbers_limit]
            next if num < min

            if num > max
              storage.delete(min)
              min = storage.keys.min
            end
          end

          min = num if min > num
          max = num if max < num

          storage[num] = 0 unless storage.key?(num)
          storage[num] += 1
        end

        storage_values_sum = storage.values.sum
        while storage_values_sum > options[:numbers_limit] do
          if storage_values_sum - storage[min] >= options[:numbers_limit]
            storage.delete(min)
            min = storage.keys.min
          else
            storage[min] -= 1
          end
          storage_values_sum = storage.values.sum
        end
      end

      storage
    end
  end
end
