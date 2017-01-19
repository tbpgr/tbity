require 'spec_helper'

describe Tbity::Models::Markdown::Decisions do
  describe '.new' do
    let(:path) { File.expand_path("#{__dir__}/../fixture/logs") }
    let(:expected_markdown) do
      <<-EOS
## <i class="fa fa-user" style="font-size:1em;"></i> 意思決定
自身の未来に強く影響を及ぼす意思決定を行った数を記録します。
何をもって強く影響を及ぼすと考えるかどうかの基準は **主観** です。

### <i class="fa fa-cube" style="font-size:1em;"></i> 意思決定数
<div style="font-size:75px;" class="animated infinite bounce">25</div>
      EOS
    end

    it do
      # given
      git_logs = Tbity::Models::GitLogs.new(path)
      Tbity::Models::Activity.load(git_logs.load({}))
      activities = Tbity::Models::Activity.all

      # when
      decisions = described_class.new(activities)

      # then
      expect(decisions.activities).to eq(activities)
    end
  end

  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
      <<-EOS
## <i class="fa fa-user" style="font-size:1em;"></i> 意思決定
自身の未来に強く影響を及ぼす意思決定を行った数を記録します。
何をもって強く影響を及ぼすと考えるかどうかの基準は **主観** です。

### <i class="fa fa-cube" style="font-size:1em;"></i> 意思決定数
<div style="font-size:75px;" class="animated infinite bounce">8</div>
      EOS
    end

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      git_logs = Tbity::Models::GitLogs.new(path)
      Tbity::Models::Activity.load(git_logs.load({}))

      # when
      decisions = described_class.new(Tbity::Models::Activity.all)

      # then
      expect(decisions.to_markdown).to eq(expected_markdown)
    end
  end
end
