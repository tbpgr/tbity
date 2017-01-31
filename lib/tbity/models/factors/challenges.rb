module Tbity::Models::Factors
  class Challenges < Base
    key '挑戦'
    template <<-EOS
## <i class="fa fa-sun-o" style="font-size:1em;"></i> 挑戦
はじめての挑戦をした場合に記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 挑戦数
<div style="font-size:75px;" class="animated infinite bounce"><%=count%></div>
    EOS
  end
end
