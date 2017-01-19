module Tbity::Models
  class Activity
    include Enumerable

    COLUMNS = [:date, :category, :sub_category, :status].freeze
    COLUMNS.each { |e| attr_reader e }

    class << self
      def load(logs)
        @rows = logs.each_line.map(&:chomp).map { |e| new(e) }
      end

      def each
        @rows.each { |e| yield(e) }
      end

      def all
        @rows
      end
    end

    def initialize(row)
      columns = row.split(',')
      COLUMNS.each.with_index do |variable, i|
        instance_variable_set("@#{variable}", columns[i])
      end
    end
  end
end
