class DateTime
  class << self
    def first_day(yyyymm)
      DateTime.new(year(yyyymm), month(yyyymm), 1)
    end

    def last_day(yyyymm)
      (DateTime.new(year(yyyymm), month(yyyymm), 1) >> 1) - 1
    end

    private

    def year(yyyymm)
      yyyymm[0, 4].to_i
    end

    def month(yyyymm)
      yyyymm[4, 6].to_i
    end
  end
end
