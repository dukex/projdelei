require 'open-uri'

class LawProjectParser
  URL_BASE = "http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?sigla=PL&numero=&ano=#{Time.now.year}&datApresentacaoIni=&datApresentacaoFim=&autor=&parteNomeAutor=&siglaPartidoAutor=&siglaUFAutor=&generoAutor=&codEstado=&codOrgaoEstado=&emTramitacao="

  def self.each(&block)
    (data/"proposicao").reverse_each &block
  end

  private

  def self.url
    "#{URL_BASE}"
  end

  def self.data
    Nokogiri::XML open(url,"User-Agent" => "ProjDeLei Bot" ).read
  end
end


module Nokogiri
  module XML
    class Element
      def pl_id
        @pl_id ||= (self/"id").first.text
      end

      def proposition
        (self/"nome").first.text
      end

      def link
        "http://www.camara.gov.br/sileg/Prop_Detalhe.asp?id=#{pl_id}"
      end

      def ementa
        css("txtEmenta").text
      end

      def explication
        _explication = css("txtExplicacaoEmenta").text.clean
        _explication.blank? ? ementa : _explication
      end
    end
  end
end
