class Scraper
  URL_BASE = "http://www.camara.gov.br/sileg"
  attr_accessor :url, :item

  def initialize
    @url = "#{URL_BASE}/Prop_Lista.asp?Ano=#{Time.now.year}&Sigla=PL&OrgaoOrigem=todos"
  end

  def pl_id
    item.css("input").first["value"].split(";")[0].to_i
  end

  def proposition
    clean(item.css(".iconDetalhe")[0].text)
  end

  def link
    "#{URL_BASE}/Prop_Detalhe.asp?id=#{pl_id}"
  end

  def explication
    ementa = (item/"tr[2]/td[2]/p[2]").to_s.match(/<b>Ementa: (.*)<b>/)
    ementa = (item/"tr[2]/td[2]/p[2]").to_s.match(/<b>Ementa: (.*)<\/p>/m) if ementa.nil?
    clean(ementa.captures[0])
  end
  end

  def remove_tag(string)
    string.gsub(/<\/.>|<.>/, "")
  end

  def remove_newline(string)
    string.gsub(/\n/, " ")
  end

  def remove_tabulation(string)
    string.gsub(/\t/, " ")
  end

  def remove_double_space(string)
    string.gsub(/\s+/," ")
  end

  def remove_last_space(string)
    string.gsub(/\s$/, "")
  end

  def clean(string)
    %w{tag tabulation newline double_space last_space}.each{|m| string = send("remove_#{m}", string) }
    string
  end
end
