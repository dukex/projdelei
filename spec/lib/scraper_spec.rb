require File.expand_path('spec/spec_helper')
require File.expand_path('spec/support/fixture/camaragov')

describe Scraper do
  include Rack::Test::Methods

  before do
    @pl8054 = Scraper.new
    @pl8054.item = fixture("PL_8054_2011");
  end

  describe "URL_BASE" do
    it "should be 'http://www.camara.gov.br/sileg'" do
      Scraper::URL_BASE.should eql('http://www.camara.gov.br/sileg')
    end
  end

  describe "@url" do
    it "should not be nil" do
      subject.url.should_not be_nil
    end

    it "should contain URL_BASE" do
      subject.url.should match(Scraper::URL_BASE)
    end

    it "should contain Prop_Lista.asp?" do
      subject.url.should match /Prop_Lista.asp\?/
    end

    it "should have 2010 when year is 2010" do
      Time.stub!(:now).and_return(Time.parse("Sun Dec 05 00:52:13 -0200 2010"))
      subject.url.should match /2010/
    end

    it "should be Sigla equal PL" do
      subject.url.should match /Sigla=PL/
    end

    it "should be have Orgao Origem equal todos" do
      subject.url.should match /OrgaoOrigem=todos/
    end
  end

  describe "@item" do
    it "should has item variable" do
      subject.item = "xxxx"
      subject.item.should eql("xxxx")
    end
  end

  describe "#pl_id" do
    it "should be equal 490823" do
      @pl8054.pl_id.should eql(490823)
    end
  end

  describe "#proposition" do
    it "should be equal 'PL-8054/201'" do
      @pl8054.proposition.should eql("PL-8054/2011")
    end
  end

  describe "#link" do
    it "should contain URL_BASE" do
      @pl8054.link.should match(Scraper::URL_BASE)
    end

    it "should contain 'Prop_Detalhe.asp?id='" do
      @pl8054.link.should match /Prop_Detalhe.asp\?id=/
    end

    it "should contain $pl_id" do
      @pl8054.link.should match /490823/
    end
  end

  describe "#clean" do
    let(:pl){ Scraper.new }

    it "should remove html tag"  do
      sentence = "<b>Hello Word</b>"
      pl.clean(sentence).should eql("Hello Word")
    end

    it "should remove newline" do
      sentence = "Hello\nWord"
      pl.clean(sentence).should eql("Hello Word")
    end

    it "should remove tabulation" do
      sentence = "Hello\tWord"
      pl.clean(sentence).should eql("Hello Word")
    end

    it "should remove double space" do
      sentence = "Hello  Word"
      pl.clean(sentence).should eql("Hello Word")
    end

    it "should remove last space" do
      sentence = "Hello Word "
      pl.clean(sentence).should eql("Hello Word")
    end
  end

  describe "#explication" do
    it "should be 'Estabelece normas para o processo e julgamento dos crimes contra propriedade imaterial (violação do direito autoral)'" do
      @pl8054.explication.should match "Estabelece normas para o processo e julgamento dos crimes contra propriedade imaterial "
    end
  end
end
