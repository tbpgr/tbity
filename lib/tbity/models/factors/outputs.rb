module Tbity::Models::Factors
  class Outputs < Base
    attr_reader :outputs
    SUB_CATEGORY_CONVERTER = {
      "TbpgrBlog" => "[Tbpgr Blog](http://tbpgr.hatenablog.com/)",
      "Empower" => "[Empowerment Engineering](http://empowerment-engineering.hatenablog.com/)",
      "Qiita" => "[Qiita](http://qiita.com/tbpgr)",
      "CodeIQ出題" => "[CodeIQ Tbpgr 問題](https://codeiq.jp/q/search?combine=tbpgr&name=tbpgr)",
      "絵文字ドット絵" => "[絵文字ドット絵](https://twitter.com/i/moments/821017717943566336)",
    }

    key 'アウトプット'
    template <<-EOS
## <i class="fa fa-trophy" style="font-size:1em;"></i> アウトプット
プログラム、ブログ記事、プレゼンなどのアウトプット数を記録します。

### <i class="fa fa-cube" style="font-size:1em;"></i> アウトプット数
<div style="font-size:75px;" class="animated infinite bounce"><%=count%></div>

### <i class="fa fa-list" style="font-size:1em;"></i> アウトプット記録
アウトプットしたものを記録します

|Output|Count|
|:---|---:|
<%=outputs%>
    EOS

    def preset
      find_outputs
    end

    private

    def find_outputs
      @outputs = activities.select { |e| e.category == key }
            .reject { |e| e.sub_category.empty? }
            .map{|e|e.sub_category}
            .group_by{|e|e}
            .map{|k, v|{ name: k, size: v.size}}
            .sort_by{|e|-e[:size]}
            .map{|e|convert_sub_category(e)}
            .map{|e|"|#{e[:name]}|#{e[:size]}|"}
            .join("\n")
    end

    def convert_sub_category(hash)
      return hash unless SUB_CATEGORY_CONVERTER.has_key?(hash[:name])
      {
        name: SUB_CATEGORY_CONVERTER[hash[:name]],
        size: hash[:size]
      }
    end
  end
end
