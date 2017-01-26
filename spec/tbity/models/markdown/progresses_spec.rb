require 'spec_helper'

describe Tbity::Models::Markdown::Progresses do
  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
      <<-EOS
## <i class="fa fa-bar-chart" style="font-size:1em;"></i> 進捗
個人活動の進捗に影響を与えるタスクを実施した日数を記録します。<br>
これは活動における「メインストーリー」に関わる進捗に限定します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 進捗数
<div style="font-size:75px;" class="animated infinite bounce">11</div>
      EOS
    end

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      Tbity::Models::Activity.load(git_logs.load)

      # when
      progresses = described_class.new(Tbity::Models::Activity.all)

      # then
      expect(progresses.to_markdown).to eq(expected_markdown)
    end
  end
end
