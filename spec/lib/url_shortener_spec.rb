require File.expand_path('spec/spec_helper')

describe UrlShortener do
  describe "#shorten" do
    before do
      user = "duke"
      api_token = "abc123"
      url = "http://urlmuitolonga.com.br/"

      FakeWeb.register_uri(:get, "http://api.j.mp/v3/shorten?login=#{user}&apiKey=#{api_token}&longUrl=#{url}&format=txt", :body => "http://j.mp/23")
      YAML.stub(:load_file) { {'api_token' => api_token, 'user' => user } }
    end


    it "should load config file" do
      url = "http://urlmuitolonga.com.br/"
      YAML.should_receive(:load_file).with(File.expand_path("../config/jmp.yml"))
      UrlShortener.shorten(url)
    end

    it "should shorten url" do
      UrlShortener.shorten("http://urlmuitolonga.com.br/").should eql("http://j.mp/23")
    end
  end
end
