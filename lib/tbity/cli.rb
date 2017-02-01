require "thor"

module Tbity
  class CLI < Thor
    class_option :help, type: :boolean, aliases: '-h', desc: 'help message.'
    class_option :version, type: :boolean, desc: 'version'
    class << self
      def exit_on_failure?
        true
      end
    end

    desc "factors [YYYYMM]", "月次冒険記録のMarkdownを出力する"
    def factors(yyyymm)
      path = ::Dir.pwd
      action = ::Tbity::Actions::Markdown.new(path, yyyymm)
      puts action.run
    end

    desc "metrics [YYYYMM] [OPTIONS]", "月次冒険記録のメトリクスを出力する"
    method_option :header, type: :boolean, default: false, aliases: "-h"
    def metrics(yyyymm)
      path = ::Dir.pwd
      action = ::Tbity::Actions::Metrics.new(path, yyyymm, options)
      puts action.run
    end

    desc 'version', 'version'
    def version
      puts Tbity::VERSION
    end
  end
end
