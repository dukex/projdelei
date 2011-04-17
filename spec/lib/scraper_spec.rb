require File.expand_path('spec/spec_helper')
require File.expand_path('spec/support/camaragov')

describe Scraper do
  include Rack::Test::Methods

  describe "#run!"  do
    before do
      FakeWeb.register_uri(:get, "http://www.camara.gov.br/sileg/Prop_Lista.asp?Ano=#{Time.now.year}&Sigla=PL&OrgaoOrigem=todos", :body => fixture("list"))
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
