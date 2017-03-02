require 'date'

module Tbity::Models::Factors
  class Whole
    attr_reader :date
    attr_reader :activities

    TEMPLATE = <<-EOS.freeze
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

## <i class="fa fa-bar-chart" style="font-size:1em;"></i> 推移
<iframe src="https://docs.google.com/spreadsheets/d/1ALUydGUj6-4RSvTjvb2AuiH_eeZQJ24mRB79UN61U1s/pubhtml?widget=true&amp;headers=false" style="width:1100px;height:200px;"></iframe>
    EOS

    METRICS_FACTORS = %w(yyyymm Challenges Decisions Empowers Knowledges Levels Outputs Progresses Readings Tools)

    def initialize(activities, date = DateTime.now)
      @activities = activities
      @date = date
    end

    def to_markdown
      ERB.new(TEMPLATE).result(binding)
    end

    def to_metrics_with_header
      to_tsv(get_metrics, [METRICS_FACTORS])
    end

    def to_metrics_without_header
      to_tsv(get_metrics, [])
    end

    private

    %w(Challenges Decisions Levels Empowers Progresses Knowledges Readings Tools Outputs).each do |klass|
      instance_eval do
        define_method klass.downcase do
          obj = get_factor(klass)
          obj.to_markdown
        end
      end
    end

    def get_factor(klass)
      Object.const_get("::Tbity::Models::Factors::#{klass}").new(activities, date)
    end

    def level
      ::Tbity::Models::Factors::Levels.new(activities, date).load_level
    end

  def get_metrics
    %w(Challenges Decisions Empowers Progresses Knowledges Readings Tools Outputs).each_with_object(yyyymm: date.strftime('%Y/%m')) do |klass, memo|
      obj = get_factor(klass)
      memo[klass.downcase.to_sym] = obj.count
    end
  end

    def to_tsv(metrics, default_tsv)
      header = METRICS_FACTORS
      body = header.map { |e| metrics[e.downcase.to_sym] }
      tsv = default_tsv
      tsv.push(body)
      tsv.map { |e| e.join("\t") }.join("\n")
    end
  end
end
