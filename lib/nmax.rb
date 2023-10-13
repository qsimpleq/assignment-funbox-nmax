# frozen_string_literal: true

module Nmax
  NMAXDIR = File.absolute_path("#{File.dirname(__FILE__)}/nmax").freeze

  class Error < StandardError; end

  def self.build(options)
    Runner.new(options)
  end
end
Nmax.autoload(:Runner, "#{Nmax::NMAXDIR}/runner")
Nmax.autoload(:StreamParser, "#{Nmax::NMAXDIR}/stream_parser")
Nmax.autoload(:StreamReader, "#{Nmax::NMAXDIR}/stream_reader")
Nmax.autoload(:VERSION, "#{Nmax::NMAXDIR}/version")
