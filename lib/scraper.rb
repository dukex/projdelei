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
    (item/"*[@class='rightIconified iconDetalhe']").text
  end

  def link
    "#{URL_BASE}/Prop_Detalhe.asp?id=#{pl_id}"
  end

  def explication
    (item/"tr[2]/td[2]/p[2]").text.split(/Explica.*o:/)[1]
  end

end
