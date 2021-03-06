require 'spec_helper'

describe Tbity::Models::Factors::Challenges do
  let(:instance) do
    path = File.expand_path("#{__dir__}/../../../fixture/logs")
    logs = File.read(path, encoding: 'UTF-8')
    allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
    period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))
    git_logs = ::Tbity::Models::GitLogs.new(path, period)
    Tbity::Models::Activity.load(git_logs.load)
    described_class.new(Tbity::Models::Activity.all)
  end


  describe '#to_markdown' do
    let(:expected) do
      <<-EOS
## <i class="fa fa-sun-o" style="font-size:1em;"></i> 挑戦
はじめての挑戦をした場合に記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 挑戦数
<div style="font-size:75px;" class="animated infinite bounce">2</div>
      EOS
    end

    it { expect(instance.to_markdown).to eq(expected) }
  end

  describe '#count' do
    it { expect(instance.count).to eq(2) }
  end
end
