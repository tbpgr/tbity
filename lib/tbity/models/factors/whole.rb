require "date"

module Tbity::Models::Factors
  class Whole
    attr_reader :date
    attr_reader :activities

    TEMPLATE =<<-EOS
[冒険記録]Lv <%=level%> - てぃーびー <%=date.year%> 年 <%=date.month%> 月 冒険記録 - 手動入力のサブタイトル

![eye_catch](https://img.esa.io/uploads/production/attachments/912/2017/01/09/1893/5c600166-e1c4-4adb-953b-e0643817d1f1.png)

てぃーびーの <%=date.year%> 年 <%=date.month%> 月の冒険の記録をまとめます。

<!-- more -->

## <i class="fa fa-comments" style="font-size:1em;"></i> 雑感
ここは手動の雑感コメント欄

<%=levels%>
<%=empowers%>
<%=decisions%>
<%=progresses%>
<%=knowledges%>
<%=readings%>
<%=tools%>
<%=outputs%>
<%=challenges%>
    EOS

    def initialize(activities, date = DateTime.now)
      @activities = activities
      @date = date
    end

    def to_markdown
      ERB.new(TEMPLATE).result(binding)
    end

    private

    %w(Challenges Decisions Levels Empowers Progresses Knowledges Readings Tools Outputs).each do |klass|
      instance_eval do
        define_method klass.downcase do
          obj = Object.const_get("::Tbity::Models::Factors::#{klass}").new(activities, date)
          obj.to_markdown
        end
      end
    end

    def level
      ::Tbity::Models::Factors::Levels.new(activities, date).load_level
    end
  end
end
