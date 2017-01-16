require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rubocop/rake_task'
require 'rubycritic/rake_task'
require "bump/tasks"
require "bump"

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new
RubyCritic::RakeTask.new do |task|
  task.paths = FileList['lib/**/*.rb']
end

task :default => :spec

desc '静的解析、テストを全て実行'
task full: %w(rubocop rubycritic spec)

namespace :bump do
  module Bump
    class Bump
      README = "README.md"
      def self.update_readme
        updated = File.read(README).gsub(/version\-v(\d{1,}\.\d{1,}\.\d{1,})\-orange\.svg/, "version-v#{current}-orange.svg")
        File.open(README, "w") {|e|e.puts updated}
      end
    end
  end

  desc "bump up patch - version.rb, README badge"
  task :patch_all do
    Bump::Bump.run("patch")
    # Bump::Bump.update_readme
  end

  desc "bump up minor - version.rb, README badge"
  task :minor_all do
    Bump::Bump.run("minor")
    # Bump::Bump.update_readme
  end

  desc "bump up major - version.rb, README badge"
  task :major_all do
    Bump::Bump.run("major")
    # Bump::Bump.update_readme
  end
end
