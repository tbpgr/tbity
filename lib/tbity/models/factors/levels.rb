require 'date'

module Tbity::Models::Factors
  class Levels < Base
    # 2016/12月をレベル1とする
    START = DateTime.new(2016, 12)
    attr_reader :level

    key '挑戦'
    template <<-EOS
## <i class="fa fa-level-up" style="font-size:1em;"></i> Lv
てぃーびーはLv <div style="font-size:75px;" class="animated infinite bounce"><%=level%></div> に上がりました
    EOS

    def preset
      @level = load_level
    end

    def load_level
      (date.year * 12 + date.month) - (START.year * 12 + START.month)
    end
  end
end
