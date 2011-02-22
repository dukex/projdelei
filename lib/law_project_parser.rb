require 'open-uri'

class LawProjectParser
  URL_BASE = "http://www.camara.gov.br/sileg"

  def self.each(&block)
    (data/"body/div/div[3]/div/div/div/div/form/table/tbody").reverse_each &block
  end

  private

  def self.url
    "#{URL_BASE}/Prop_Lista.asp?Ano=#{Time.now.year}&Sigla=PL&OrgaoOrigem=todos"
  end

  def self.data
    Nokogiri::HTML open(url,"User-Agent" => "ProjDeLei Bot" ).read
  end
end


module Nokogiri
  module XML
    class Element
      def pl_id
        css("input").first["value"].split(";")[0].to_i
      end

      def proposition
        css(".iconDetalhe")[0].text.clean
      end

      def link
        LawProjectParser::URL_BASE + "/Prop_Detalhe.asp?id=#{pl_id}"
      end

      def ementa
        (self/"tr[2]/td[2]/p[2]").to_s.match(/<b>Ementa: (.*)<b>/) || (self/"tr[2]/td[2]/p[2]").to_s.match(/<b>Ementa: (.*)<\/p>/m)
      end

      def explication
        ementa.captures[0].clean
      end
    end
  end
end
