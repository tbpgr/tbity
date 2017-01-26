require 'open3'

module Tbity::Models
  class GitLogs
    attr_reader :path
    attr_reader :period

    def initialize(path, period)
      @path = path
      @period = period
    end

    def load
      stdout, _, _ = ::Open3.capture3(git_command)
      stdout
    end

    private

    def git_command
      <<-GIT
cd #{path} && git log --date=short --pretty=format:'%ad,%s' #{after_option(period.from)} #{before_option(period.to)}
      GIT
    end

    def before_option(before)
      return '' unless before
      "--before='#{before.strftime("%Y-%m-%d")}'"
    end

    def after_option(after)
      return '' unless after
      "--after='#{after.strftime("%Y-%m-%d")}'"
    end
  end
end
