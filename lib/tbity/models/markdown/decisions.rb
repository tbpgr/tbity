module Tbity::Models::Markdown
  class Decisions < Base
    key '意思決定'
    template <<-EOS
## <i class="fa fa-user" style="font-size:1em;"></i> 意思決定
自身の未来に強く影響を及ぼす意思決定を行った数を記録します。<br>
何をもって強く影響を及ぼすと考えるかどうかの基準は **主観** です。

### <i class="fa fa-cube" style="font-size:1em;"></i> 意思決定数
<div style="font-size:75px;" class="animated infinite bounce"><%=count_category%></div>
    EOS
  end
end
