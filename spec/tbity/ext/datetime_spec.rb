require 'spec_helper'

describe DateTime do
  describe '.first_day' do
    it { expect(described_class.first_day("201701")).to eq(DateTime.new(2017, 1, 1)) }
  end

  describe '.last_day' do
    it { expect(described_class.last_day("201701")).to eq(DateTime.new(2017, 1, 31)) }
  end
end
