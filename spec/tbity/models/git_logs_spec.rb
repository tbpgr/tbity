require 'spec_helper'

describe Tbity::Models::GitLogs do
  describe '.new' do
    let(:path) { File.expand_path("#{__dir__}/../../fixture/repository") }

    it "path" do
      # given

      # when
      git_logs = described_class.new(path)

      # then
      expect(git_logs.path).to eq(path)
    end
  end

  describe '.load' do
    let(:logs) { File.read(File.expand_path("#{__dir__}/../../fixture/logs")) }

    it "log" do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      git_logs = described_class.new(File.expand_path("#{__dir__}/../../fixture/repository"))

      # when
      actual_logs = git_logs.load

      # then
      expect(actual_logs).to eq(logs)
    end
  end
end
