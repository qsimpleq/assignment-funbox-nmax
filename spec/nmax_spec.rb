# frozen_string_literal: true

def expect_pair_equal(pair)
  expect(pair[0]).to eq(pair[1])
end

def pair(name, options = {})
  input, output = load_fixture_pair(name)
  stream = StringIO.new(input.to_s)
  klass = described_class.build({ number_max_length: 3, numbers_limit: 10, stream: stream }.merge(options))

  [klass.sorted_result.join("\n"), output.strip]
end

def load_fixture_pair(name)
  [load_fixture(name), load_fixture("#{name}_result")]
end

RSpec.describe Nmax do
  it 'has a version number' do
    expect(Nmax::VERSION).not_to be nil
  end

  it 'check ByChunk' do
    options = { parser: :ByChunk }
    expect_pair_equal pair(:no_numbers, options)
    expect_pair_equal pair(:one_numbers, options)
    expect_pair_equal pair(:ten_numbers, options)
  end

  it 'check ByLine' do
    options = { parser: :ByLine }
    expect_pair_equal pair(:no_numbers, options)
    expect_pair_equal pair(:one_numbers, options)
    expect_pair_equal pair(:ten_numbers, options)
  end
end
