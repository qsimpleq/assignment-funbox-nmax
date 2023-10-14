# frozen_string_literal: true

require 'rspec'
require 'nmax'

module TestHelpers
  def load_fixture(file_name)
    File.read("#{File.dirname(__FILE__)}/fixtures/#{file_name}.txt")
  end
end

RSpec.configure do |config|
  config.include TestHelpers

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
