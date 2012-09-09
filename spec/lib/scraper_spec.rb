require File.expand_path('spec/spec_helper')
require File.expand_path('spec/support/camaragov')

describe Scraper do
  include Rack::Test::Methods

  describe "#run!"  do
    before do
      stub_request(:get, "http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?OrgaoOrigem=todos&Sigla=PL&ano=2012&autor=&codEstado=&codOrgaoEstado=&datApresentacaoFim=&datApresentacaoIni=&emTramitacao=/Prop_Lista.asp?Ano=2012&generoAutor=&numero=&parteNomeAutor=&sigla=PL&siglaPartidoAutor=&siglaUFAutor=").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'ProjDeLei Bot'}).
         to_return(:status => 200, :body => fixture("pl_list.xml"))
    end

    it "should save 30 register in database" do
      Scraper.run!
      LawProject.count.should eql(30)
    end

    it "should not save if have register" do
      Scraper.run!
      Scraper.run!
      LawProject.count.should eql(30)
    end

    it "should save pl_id for law" do
      Scraper.run!
      LawProject.first.pl_id.should eql(493873)
    end

    it "should save proposition for law" do
      Scraper.run!
      LawProject.first.proposition.should eql("PL-8085/2011 REP-1210")
    end

    it "should save link for law" do
      Scraper.run!
      LawProject.first.link.should eql("http://www.camara.gov.br/sileg/Prop_Detalhe.asp?id=493873")
    end

    it "should save explication for law" do
      Scraper.run!
      LawProject.first.explication.should eql("Dispõe sobre a presunção de justa causa para desfiliação partidária a não concessão de legenda ao detentor de mandato eletivo, em efetivo exercício, que deseje concorrer ao mesmo cargo político, nas eleições que renove o seu mandato.")
    end
  end
end
