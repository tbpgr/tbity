require 'spec_helper'

describe Tbity::Models::Factors::Decisions do
  let(:instance) do
    path = File.expand_path("#{__dir__}/../../../fixture/logs")
    logs = File.read(path, encoding: 'UTF-8')
    allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
    period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))
    git_logs = ::Tbity::Models::GitLogs.new(path, period)
    Tbity::Models::Activity.load(git_logs.load)
    described_class.new(Tbity::Models::Activity.all)
  end

  describe '.new' do
    it { expect(instance.activities).to eq(Tbity::Models::Activity.all) }
  end

  describe '#to_markdown' do
    let(:expected) do
      <<-EOS
## <i class="fa fa-user" style="font-size:1em;"></i> 意思決定
自身の未来に強く影響を及ぼす意思決定を行った数を記録します。<br>
何をもって強く影響を及ぼすと考えるかどうかの基準は **主観** です。

### <i class="fa fa-cube" style="font-size:1em;"></i> 意思決定数
<div style="font-size:75px;" class="animated infinite bounce">8</div>
      EOS
    end

    it { expect(instance.to_markdown).to eq(expected) }
  end


  describe '#count' do
    it { expect(instance.count).to eq(8) }
  end
end
