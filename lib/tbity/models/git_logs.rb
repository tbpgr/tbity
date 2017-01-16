require "open3"

module Tbity::Models
  class GitLogs
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def load
      stdout, = ::Open3.capture3("cd #{path} && git log --date=short --pretty=format:'%ad,%s'")
      stdout
    end
  end
end
