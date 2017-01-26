require 'spec_helper'

describe Tbity::Models::Markdown::Empowers do
  describe '.new' do
    let(:path) { File.expand_path("#{__dir__}/../fixture/logs") }

    it do
      # given
      period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      Tbity::Models::Activity.load(git_logs.load)
      activities = Tbity::Models::Activity.all

      # when
      empowers = described_class.new(activities)

      # then
      expect(empowers.activities).to eq(activities)
    end
  end

  describe '#to_markdown' do
    let(:path) { File.expand_path("#{__dir__}/../../../fixture/logs") }
    let(:logs) { File.read(path, encoding: 'UTF-8') }
    let(:expected_markdown) do
      <<-EOS
## <i class="fa fa-users" style="font-size:1em;"></i> 支援
自分に関わる人物に対して支援を行った場合に記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 支援数
<div style="font-size:75px;" class="animated infinite bounce">13</div>
      EOS
    end

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([logs, 'stderr', 0])
      period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      Tbity::Models::Activity.load(git_logs.load)

      # when
      empowers = described_class.new(Tbity::Models::Activity.all)

      # then
      expect(empowers.to_markdown).to eq(expected_markdown)
    end
  end
end
