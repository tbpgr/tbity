require 'spec_helper'

describe Tbity::Models::Markdown::Knowledges do
  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
      <<-EOS
## <i class="fa fa-graduation-cap" style="font-size:1em;"></i> 知識
新たに得た知識を記録します。  
鳥の記憶力を誇るのですぐに忘れるかもしれませんが、  
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

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      git_logs = Tbity::Models::GitLogs.new(path)
      Tbity::Models::Activity.load(git_logs.load({}))
      knowledges = described_class.new(Tbity::Models::Activity.all)

      # when
      knowledges.find_knowledges

      # then
      expect(knowledges.to_markdown).to eq(expected_markdown)
    end
  end
end
