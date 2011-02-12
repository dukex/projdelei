require 'spec_helper.rb'

describe Scraper do
  include Rack::Test::Methods

  before do
    @scraper = Scraper.new
  end

  describe "#url" do
    it "should not be nil" do
      @scraper.url.should_not be_nil
    end

    it "should contains camara.gov.br" do
      @scraper.url.should match(/camara\.gov\.br/)

    end
    it "should url contains 2010 when year is 2010" do
      @time_now = Time.parse("Sun Dec 05 00:52:13 -0200 2010")
      Time.stub!(:now).and_return(@time_now)
      @scraper = Scraper.new
      @scraper.url.should match(/2010/)
    end
  end
end



