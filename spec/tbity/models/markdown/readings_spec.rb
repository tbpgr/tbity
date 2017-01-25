require 'spec_helper'

describe Tbity::Models::Markdown::Readings do
  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
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

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      git_logs = Tbity::Models::GitLogs.new(path)
      Tbity::Models::Activity.load(git_logs.load({}))

      # when
      readings = described_class.new(Tbity::Models::Activity.all)

      # then
      expect(readings.to_markdown).to eq(expected_markdown)
    end
  end
end