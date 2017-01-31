require 'spec_helper'

describe Tbity::Models::Factors::Readings do
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
## <i class="fa fa-book" style="font-size:1em;"></i> 読書
### <i class="fa fa-cube" style="font-size:1em;"></i> 読書回数
<div style="font-size:75px;" class="animated infinite bounce">7</div>

### <i class="fa fa-list" style="font-size:1em;"></i> 読書記録
読了した書籍を記録します。

1. その「エンジニア採用」が不幸を生む
1. アテンション
      EOS
    end

    it { expect(instance.to_markdown).to eq(expected) }
  end


  describe '#count' do
    it { expect(instance.count).to eq(7) }
  end
end

