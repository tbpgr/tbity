module Tbity::Models::Factors
  class Readings < Base
    attr_reader :readings

    key '読書'
    template <<-EOS
## <i class="fa fa-book" style="font-size:1em;"></i> 読書
### <i class="fa fa-cube" style="font-size:1em;"></i> 読書回数
<div style="font-size:75px;" class="animated infinite bounce"><%=count%></div>

### <i class="fa fa-list" style="font-size:1em;"></i> 読書記録
読了した書籍を記録します。

<%=readings%>
    EOS

    def preset
      find_readings
    end

    private

    def find_readings
      @readings = activities.select { |e| e.category == key && e.status == '完了' }
                .reject { |e| e.sub_category.empty? }
                .map { |e| "1. #{e.sub_category}"}
                .sort
                .join("\n")
    end
  end
end
