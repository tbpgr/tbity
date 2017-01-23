module Tbity::Models::Markdown
  class Progresses < Base
    key '進捗'
    template <<-EOS
## <i class="fa fa-bar-chart" style="font-size:1em;"></i> 進捗
個人活動の進捗に影響を与えるタスクを実施した日数を記録します。
これは活動における「メインストーリー」に関わる進捗に限定します。

### <i class="fa fa-cube" style="font-size:1em;"></i> 進捗数
<div style="font-size:75px;" class="animated infinite bounce"><%=count_category%></div>
    EOS
  end
end
