module Tbity::Models::Markdown
  class Empowers < Base
    key '支援'
    template <<-EOS
## <i class="fa fa-users" style="font-size:1em;"></i> 支援
自分に関わる人物に対して支援を行った場合に記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 支援数
<div style="font-size:75px;" class="animated infinite bounce"><%=count_category%></div>
    EOS
  end
end
