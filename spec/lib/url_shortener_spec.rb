require File.expand_path('spec/spec_helper')

describe UrlShortener do
  describe "#shorten" do
    before do
      user = "duke"
      api_token = "abc123"
      url = "http://urlmuitolonga.com.br/"

      stub_request(:get, "http://api.j.mp/v3/shorten?apiKey=abc123&format=txt&login=duke&longUrl=http://urlmuitolonga.com.br/").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "http://j.mp/23", :headers => {})
      YAML.stub(:load_file) { {'api_token' => api_token, 'user' => user } }
    end


    it "should load config file" do
      url = "http://urlmuitolonga.com.br/"
      YAML.should_receive(:load_file).with(File.expand_path("config.yml"))
      UrlShortener.shorten(url)
    end

    it "should shorten url" do
      UrlShortener.shorten("http://urlmuitolonga.com.br/").should eql("http://j.mp/23")
    end
  end
end
