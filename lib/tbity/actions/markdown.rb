module Tbity::Actions
  class Markdown
    attr_reader :period
    attr_reader :yyyymm
    attr_reader :path

    def initialize(path, yyyymm)
      @path = path
      @yyyymm = yyyymm
      year = yyyymm[0, 4].to_i
      month = yyyymm[4, 6].to_i
      from = DateTime.new(year, month, 1)
      to = (DateTime.new(year, month, 1) >> 1) - 1
      @period = ::Tbity::Models::Period.new(from: from, to: to)
    end

    def run
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      ::Tbity::Models::Activity.load(git_logs.load)
      whole = ::Tbity::Models::Markdown::Whole.new(Tbity::Models::Activity.all, period.from)
      whole.to_markdown
    end
  end
end
