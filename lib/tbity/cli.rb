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

    desc "factors [YYYYMM]", "月次冒険記録Factorsを出力する"
    def factors(yyyymm)
      path = ::Dir.pwd
      action = ::Tbity::Actions::Markdown.new(path, yyyymm)
      puts action.run
    end

    desc 'version', 'version'
    def version
      puts Tbity::VERSION
    end
  end
end
