require 'spec_helper'

describe Tbity::Models::Markdown::Challenges do
  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
      <<-EOS
## <i class="fa fa-sun-o" style="font-size:1em;"></i> 挑戦
はじめての挑戦をした場合に記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 挑戦数
<div style="font-size:75px;" class="animated infinite bounce">2</div>
      EOS
    end

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      git_logs = Tbity::Models::GitLogs.new(path)
      Tbity::Models::Activity.load(git_logs.load({}))

      # when
      challenges = described_class.new(Tbity::Models::Activity.all)

      # then
      expect(challenges.to_markdown).to eq(expected_markdown)
    end
  end
end
