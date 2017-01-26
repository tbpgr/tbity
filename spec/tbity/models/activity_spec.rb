require 'spec_helper'

describe Tbity::Models::Activity do
  describe '.load' do
    let(:path) { "#{__dir__}/../../fixture/logs" }
    let(:fixture_logs) { File.read(File.expand_path(path), encoding: 'UTF-8') }

    it do
      # given
      allow(::Open3).to receive(:capture3).and_return([fixture_logs, 'stderr', 0])
      period = ::Tbity::Models::Period.new(from: DateTime.new(2017, 1, 1), to: DateTime.new(2017, 1, 31))
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      logs = git_logs.load
      expected_size = logs.each_line.to_a.size

      # when
      activities = described_class.load(logs)
      first_activity = activities.first

      # then
      expect(activities.size).to eq(expected_size)
      expect(first_activity.date).to eq('2017-01-16')
      expect(first_activity.category).to eq('進捗')
      expect(first_activity.sub_category).to eq('Empower アンケート記事投稿')
      expect(first_activity.status).to eq('実行')
    end
  end

  describe '#new' do
    it do
      # given

      # when
      activity = described_class.new('2017-01-16,進捗,Empower アンケート記事投稿,実行')

      # then
      expect(activity.date).to eq('2017-01-16')
      expect(activity.category).to eq('進捗')
      expect(activity.sub_category).to eq('Empower アンケート記事投稿')
      expect(activity.status).to eq('実行')
    end
  end
end
