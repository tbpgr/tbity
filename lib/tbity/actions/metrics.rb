module Tbity::Actions
  class Metrics
    attr_reader :period
    attr_reader :path
    attr_reader :header

    def initialize(path, yyyymm, options = {})
      @path = path
      from = ::DateTime.first_day(yyyymm)
      to = ::DateTime.last_day(yyyymm)
      @period = ::Tbity::Models::Period.new(from: from, to: to)
      @header = options.fetch(:header, false)
    end

    def run
      git_logs = ::Tbity::Models::GitLogs.new(path, period)
      ::Tbity::Models::Activity.load(git_logs.load)
      whole = ::Tbity::Models::Factors::Whole.new(Tbity::Models::Activity.all, period.from)
      header ? whole.to_metrics_with_header : whole.to_metrics_without_header
    end
  end
end
