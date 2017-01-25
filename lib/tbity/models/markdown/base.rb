require 'erb'

module Tbity::Models::Markdown
  class Base
    attr_reader :activities
    attr_reader :date
    attr_reader :count

    class << self
      def key(key)
        define_method :key do
          key
        end
      end

      def template(template)
        define_method :template do
          template
        end
      end
    end

    def initialize(activities, date = Time.now)
      @activities = activities
      @date = date
    end

    def to_markdown
      preset
      ERB.new(template).result(binding)
    end

    def preset
      # 継承側で to_markdown 前に差し込みたい処理があったらオーバーライドする
    end

    private

    def count_category
      activities.count { |e| e.category == key }
    end
  end
end
