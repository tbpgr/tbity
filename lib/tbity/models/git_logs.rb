require 'open3'

module Tbity::Models
  class GitLogs
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def load(options = { before: nil, after: nil })
      stdout, stderr, status = ::Open3.capture3(git_command(options))
      stdout
    end

    private

    def git_command(options)
      <<-GIT
cd #{path} && git log --date=short --pretty=format:'%ad,%s' #{before_option(options[:before])} #{after_option(options[:after])}
      GIT
    end

    def before_option(before)
      return '' unless before
      "--before='#{before}'"
    end

    def after_option(after)
      return '' unless after
      "--after='#{after}'"
    end
  end
end
