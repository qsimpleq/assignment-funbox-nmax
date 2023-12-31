# frozen_string_literal: true

module Nmax
  class Runner
    attr_reader :options

    def initialize(options)
      @options = options_defaults(options)
    end

    def calculate(options = @options)
      parse_options = build_parser_options(options)
      parser = build_parser(parse_options)
      reader = build_reader(options)
      reader.run { |*args| parser.run(*args) }

      result = parse_options[:storage]
      block_given? ? yield(result) : result
    ensure
      @options[:stream].close
    end

    def sorted_result
      calculate do |result|
        result.keys.sort { |a, b| b <=> a }.map do |key|
          r = [key] * result[key]
          block_given? ? yield(r) : r
        end
      end
    end

    private

    def build_reader(options)
      StreamReader.build(options[:parser] ? options : @options)
    end

    def build_parser(options)
      StreamParser.build(options[:parser] ? options : @options)
    end

    def build_parser_options(options)
      options.merge(
        storage: {},
        min: nil,
        max: nil
      )
    end

    def options_defaults(options)
      options[:numbers_limit] ||= 10
      options[:number_max_length] ||= 1000
      options[:parser] ||= :ByChunk
      options
    end
  end
end
