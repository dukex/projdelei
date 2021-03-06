#encoding: utf-8

require File.expand_path('spec/spec_helper')
require File.expand_path('spec/support/camaragov')

describe Scraper do
  include Rack::Test::Methods

  describe "#run!"  do
    before do

      stub_request(:get, "http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?ano=2013&autor=&codEstado=&codOrgaoEstado=&datApresentacaoFim=&datApresentacaoIni=&emTramitacao=&generoAutor=&numero=&parteNomeAutor=&sigla=PL&siglaPartidoAutor=&siglaUFAutor=").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'ProjDeLei Bot'}).
         to_return(:status => 200, :body => fixture("pl_list.xml"))
    end

    it "should save 14 register in database" do
      Scraper.run!
      LawProject.count.should eql(14)
    end

    it "should not save if have register" do
      Scraper.run!
      Scraper.run!
      LawProject.count.should eql(14)
    end

    it "should save pl_id for law" do
      Scraper.run!
      LawProject.first.pl_id.should eql(555247)
    end

    it "should save proposition for law" do
      Scraper.run!
      LawProject.first.proposition.should eql("PL 4407/2012")
    end

    it "should save link for law" do
      Scraper.run!
      LawProject.first.link.should eql("http://www.camara.gov.br/sileg/Prop_Detalhe.asp?id=555247")
    end

    it "should save explication for law" do
      Scraper.run!
      LawProject.first.explication.should eql("Institui o Serviço Social Obrigatório.")
    end
  end
end
