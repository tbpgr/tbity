module Tbity::Models::Markdown
  class Levels < Base
    # 2017/01月をレベル1とする
    START = Time.new(2017, 1)
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
