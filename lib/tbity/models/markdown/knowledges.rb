module Tbity::Models::Markdown
  class Knowledges < Base
    attr_reader :knowledges

    key '知識'
    template <<-EOS
## <i class="fa fa-graduation-cap" style="font-size:1em;"></i> 知識
新たに得た知識を記録します。<br>
鳥の記憶力を誇るのですぐに忘れるかもしれませんが、<br>
記憶強化・外部脳の意味でもこれを記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 知識数
<div style="font-size:75px;" class="animated infinite bounce"><%=count_category%></div>

### <i class="fa fa-list" style="font-size:1em;"></i> 知識リスト
<%=knowledges%>
    EOS

    def preset
      find_knowledges
    end

    private

    def find_knowledges
      @knowledges = activities.select { |e| e.category == key }
                .reject { |e| e.sub_category.empty? }
                .map { |e| "1. #{e.sub_category}"}
                .sort
                .join("\n")
    end
  end
end
