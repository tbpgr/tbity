require 'spec_helper'

describe Tbity::Models::Markdown::Tools do
  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
      <<-EOS
## <i class="fa fa-wrench" style="font-size:1em;"></i> ツール
### <i class="fa fa-cube" style="font-size:1em;"></i> ツール学習数
<div style="font-size:75px;" class="animated infinite bounce">9</div>

### <i class="fa fa-list" style="font-size:1em;"></i> ツール記録
学習したツールは以下です

1. Power BI
1. Unarchiver
1. thor
      EOS
    end

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      Tbity::Models::Activity.load(git_logs.load)

      # when
      tools = described_class.new(Tbity::Models::Activity.all)

      # then
      expect(tools.to_markdown).to eq(expected_markdown)
    end
  end
end
