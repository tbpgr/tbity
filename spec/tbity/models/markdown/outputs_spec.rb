require 'spec_helper'

describe Tbity::Models::Markdown::Outputs do
  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
      <<-EOS
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
      EOS
    end

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      Tbity::Models::Activity.load(git_logs.load)

      # when
      outputs = described_class.new(Tbity::Models::Activity.all)

      # then
      expect(outputs.to_markdown).to eq(expected_markdown)
    end
  end
end
