require 'erb'

module Tbity::Models::Markdown
  class Base
    attr_reader :activities
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

    def initialize(activities)
      @activities = activities
    end

    def to_markdown
      ERB.new(template).result(binding)
    end

    private

    def count_category
      activities.count { |e| e.category == key }
    end
  end
end
