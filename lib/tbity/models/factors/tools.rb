module Tbity::Models::Factors
  class Tools < Base
    attr_reader :tools

    key 'ツール'
    template <<-EOS
## <i class="fa fa-wrench" style="font-size:1em;"></i> ツール
### <i class="fa fa-cube" style="font-size:1em;"></i> ツール学習数
<div style="font-size:75px;" class="animated infinite bounce"><%=count%></div>

### <i class="fa fa-list" style="font-size:1em;"></i> ツール記録
学習したツールは以下です

<%=tools%>
    EOS

    def preset
      find_tools
    end

    private

    def find_tools
      @tools = activities.select { |e| e.category == key }
                .reject { |e| e.sub_category.empty? }
                .map { |e| "1. #{e.sub_category}"}
                .uniq
                .sort
                .join("\n")
    end
  end
end
