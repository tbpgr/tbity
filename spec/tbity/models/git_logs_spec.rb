require 'spec_helper'

describe Tbity::Models::GitLogs do
  describe '.new' do
    let(:path) { File.expand_path("#{__dir__}/../../fixture/logs") }

    it "path" do
      # given

      # when
      git_logs = described_class.new(path)

      # then
      expect(git_logs.path).to eq(path)
    end
  end

  describe '.load' do
    let(:path) { File.expand_path("#{__dir__}/../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }

    describe 'log' do
      context 'Before のみ' do
        # TODO:
      end

      context 'After のみ' do
        # TODO:
      end

      context 'Before + After' do
        # TODO:
      end

      context '全期間' do
        it do
          # given
          allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
          git_logs = described_class.new(File.expand_path(path))

          # when
          actual_logs = git_logs.load

          # then
          expect(actual_logs).to eq(logs)
        end
      end
    end
  end
end
