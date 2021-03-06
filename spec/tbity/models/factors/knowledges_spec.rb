require 'spec_helper'

describe Tbity::Models::Factors::Knowledges do
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
## <i class="fa fa-graduation-cap" style="font-size:1em;"></i> 知識
新たに得た知識を記録します。<br>
鳥の記憶力を誇るのですぐに忘れるかもしれませんが、<br>
記憶強化・外部脳の意味でもこれを記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 知識数
<div style="font-size:75px;" class="animated infinite bounce">10</div>

### <i class="fa fa-list" style="font-size:1em;"></i> 知識リスト
1. アンダードッグ効果
1. クリフハンガー
1. ゼイガルニク効果
1. バンドワゴン効果
1. パラソーシャル関係
1. フォン・レストルフ効果
1. フレーミング効果
1. プライミング効果
1. リフレーミング効果
1. 返礼の注目
      EOS
    end

    it { expect(instance.to_markdown).to eq(expected) }
  end


  describe '#count' do
    it { expect(instance.count).to eq(10) }
  end
end
