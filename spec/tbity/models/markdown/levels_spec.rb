require 'spec_helper'

describe Tbity::Models::Markdown::Levels do
  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
      <<-EOS
## <i class="fa fa-level-up" style="font-size:1em;"></i> Lv
てぃーびーはLv <div style="font-size:75px;" class="animated infinite bounce">1</div> に上がりました
      EOS
    end

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      Tbity::Models::Activity.load(git_logs.load)

      # when
      levels = described_class.new(Tbity::Models::Activity.all, DateTime.new(2017, 1))

      # then
      expect(levels.to_markdown).to eq(expected_markdown)
    end
  end
end
