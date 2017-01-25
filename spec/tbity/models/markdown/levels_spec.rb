require 'spec_helper'

describe Tbity::Models::Markdown::Levels do
  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
      <<-EOS
## <i class="fa fa-level-up" style="font-size:1em;"></i> Lv
てぃーびーはLv <div style="font-size:75px;" class="animated infinite bounce">2</div> に上がりました
      EOS
    end

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      git_logs = Tbity::Models::GitLogs.new(path)
      Tbity::Models::Activity.load(git_logs.load({}))

      # when
      levels = described_class.new(Tbity::Models::Activity.all, Time.new(2017, 3))

      # then
      expect(levels.to_markdown).to eq(expected_markdown)
    end
  end
end
