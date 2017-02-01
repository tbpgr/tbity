require 'spec_helper'

describe Tbity::Actions::Markdown do
  describe '#initialize' do
    let(:path) { File.expand_path("#{__dir__}/../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:yyyymm) { "201701" }

    it "正常系" do
      # given
      allow_any_instance_of(Tbity::Models::GitLogs).to receive(:load).and_return(logs)
      period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))

      # when
      action = described_class.new(path, yyyymm)

      # then
      expect(action.path).to eq(path)
      expect(action.period).to eq(period)
    end
  end

  describe '#run' do
    let(:path) { File.expand_path("#{__dir__}/../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected) do
      <<-EOS
[冒険記録]Lv 1 - てぃーびー 2017 年 1 月 冒険記録 - 手動入力のサブタイトル

![eye_catch](https://img.esa.io/uploads/production/attachments/912/2017/01/09/1893/5c600166-e1c4-4adb-953b-e0643817d1f1.png)

てぃーびーの 2017 年 1 月の冒険の記録をまとめます。

<!-- more -->

## <i class="fa fa-comments" style="font-size:1em;"></i> 雑感
ここは手動の雑感コメント欄

## <i class="fa fa-level-up" style="font-size:1em;"></i> Lv
てぃーびーはLv <div style="font-size:75px;" class="animated infinite bounce">1</div> に上がりました

## <i class="fa fa-users" style="font-size:1em;"></i> 支援
自分に関わる人物に対して支援を行った場合に記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 支援数
<div style="font-size:75px;" class="animated infinite bounce">13</div>

## <i class="fa fa-user" style="font-size:1em;"></i> 意思決定
自身の未来に強く影響を及ぼす意思決定を行った数を記録します。<br>
何をもって強く影響を及ぼすと考えるかどうかの基準は **主観** です。

### <i class="fa fa-cube" style="font-size:1em;"></i> 意思決定数
<div style="font-size:75px;" class="animated infinite bounce">8</div>

## <i class="fa fa-bar-chart" style="font-size:1em;"></i> 進捗
個人活動の進捗に影響を与えるタスクを実施した日数を記録します。<br>
これは活動における「メインストーリー」に関わる進捗に限定します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 進捗数
<div style="font-size:75px;" class="animated infinite bounce">11</div>

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

## <i class="fa fa-book" style="font-size:1em;"></i> 読書
### <i class="fa fa-cube" style="font-size:1em;"></i> 読書回数
<div style="font-size:75px;" class="animated infinite bounce">7</div>

### <i class="fa fa-list" style="font-size:1em;"></i> 読書記録
読了した書籍を記録します。

1. その「エンジニア採用」が不幸を生む
1. アテンション

## <i class="fa fa-wrench" style="font-size:1em;"></i> ツール
### <i class="fa fa-cube" style="font-size:1em;"></i> ツール学習数
<div style="font-size:75px;" class="animated infinite bounce">9</div>

### <i class="fa fa-list" style="font-size:1em;"></i> ツール記録
学習したツールは以下です

1. Power BI
1. Unarchiver
1. thor

## <i class="fa fa-trophy" style="font-size:1em;"></i> アウトプット
プログラム、ブログ記事、プレゼンなどのアウトプット数を記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> アウトプット数
<div style="font-size:75px;" class="animated infinite bounce">9</div>

### <i class="fa fa-list" style="font-size:1em;"></i> アウトプット記録
アウトプットしたものを記録します

|Output|Count|
|:---|---:|
|[Empowerment Engineering](http://empowerment-engineering.hatenablog.com/)|5|
|[Qiita](http://qiita.com/tbpgr)|2|
|[CodeIQ Tbpgr 問題](https://codeiq.jp/q/search?combine=tbpgr&name=tbpgr)|1|
|[Tbpgr Blog](http://tbpgr.hatenablog.com/)|1|

## <i class="fa fa-sun-o" style="font-size:1em;"></i> 挑戦
はじめての挑戦をした場合に記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 挑戦数
<div style="font-size:75px;" class="animated infinite bounce">2</div>

      EOS
    end

    it do
      # given
      allow_any_instance_of(Tbity::Models::GitLogs).to receive(:load).and_return(logs)
      period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31, 23, 59, 59))
      action = described_class.new(path, "201701")

      # when
      actual = action.run

      # then
      expect(actual).to eq(expected)
    end
  end
end
