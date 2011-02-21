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
      Law.count.should eql(30)
    end

    it "" do
      Scraper.run!
      Scraper.run!
      Law.count.should eql(30)
    end

    it "should save pl_id for law" do
      Scraper.run!
      Law.first.pl_id.should eql(491771)
    end

    it "should save proposition for law" do
      Scraper.run!
      Law.first.proposition.should eql("PL-361/2011")
    end

    it "should save link for law" do
      Scraper.run!
      Law.first.link.should eql("http://www.camara.gov.br/sileg/Prop_Detalhe.asp?id=491771")
    end

    it "should save explication for law" do
      Scraper.run!
      Law.first.explication.should eql("Altera dispositivos da lei nº 9099 de 1995, que dispõe sobre os Juizados Especiais Cíveis e Criminais.")
    end
  end
end
