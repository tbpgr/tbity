module Tbity::Actions
  class Markdown
    attr_reader :period
    attr_reader :path

    def initialize(path, yyyymm)
      @path = path
      from = ::DateTime.first_day(yyyymm)
      to = ::DateTime.last_day(yyyymm)
      @period = ::Tbity::Models::Period.new(from: from, to: to)
    end

    def run
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      ::Tbity::Models::Activity.load(git_logs.load)
      whole = ::Tbity::Models::Factors::Whole.new(Tbity::Models::Activity.all, period.from)
      whole.to_markdown
    end
  end
end
