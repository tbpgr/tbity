require "date"

module Tbity::Models
  class Period
    attr_reader :from
    attr_reader :to

    def initialize(from: DateTime.new(1900, 1, 1), to: DateTime.new(3000, 12, 31))
      @from = from
      @to = to
      @to, @from = @from, @to if @from > @to
    end

    def ==(other)
      return false unless other.is_a?(self.class)
      (from == other.from && to == other.to)
    end
  end
end
