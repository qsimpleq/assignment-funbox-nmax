# frozen_string_literal: true

module Nmax
  class Error < StandardError; end
end
Nmax.autoload(:Runner, './nmax/runner')
Nmax.autoload(:StreamParser, './nmax/stream_parser')
Nmax.autoload(:StreamReader, './nmax/stream_reader')
Nmax.autoload(:VERSION, './nmax/version')
