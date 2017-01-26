require 'spec_helper'

describe Tbity::Models::Period do
  describe '.new' do
    [
      { title: 'from < to', from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 10),
        expected_from: DateTime.new(2017, 1, 1), expected_to: DateTime.new(2017, 1, 10) },
      { title: 'from = to', from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 1),
        expected_from: DateTime.new(2017, 1, 1), expected_to: DateTime.new(2017, 1, 1) },
      { title: 'from > to', from: DateTime.new(2017, 1, 10), to: DateTime.new(2017, 1, 1),
        expected_from: DateTime.new(2017, 1, 1), expected_to: DateTime.new(2017, 1, 10) }
    ].each do |c|
      it c[:title] do
        # given

        # when
        period = described_class.new(from: c[:from], to: c[:to])

        # then
        expect(period.from).to eq(c[:expected_from])
        expect(period.to).to eq(c[:expected_to])
      end
    end
  end

  describe '#==' do
    [
      { title: 'same type same value', from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 10),
        other: described_class.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 10)),
        expected: true },
      { title: 'same type different value', from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 9),
        other: described_class.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 10)),
        expected: false },
      { title: 'other type', from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 1),
        other: 'hoge',
        expected: false }
    ].each do |c|
      it c[:title] do
        # given
        period = described_class.new(from: c[:from], to: c[:to])

        # when
        actual = (period == c[:other])

        # then
        expect(actual).to eq(c[:expected])
      end
    end
  end
end
