require File.expand_path('spec/spec_helper')

describe UrlShortener do
  describe "#shorten" do
    before do
      user = "duke"
      api_token = "abc123"
      url = "http://urlmuitolonga.com.br/"

      stub_request(:get, "http://api.j.mp/v3/shorten?apiKey=#{api_token}&format=txt&login=#{user}&longUrl=#{url}").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "http://j.mp/23", :headers => {})

      ENV['BITLY_USER'] = user
      ENV['BITLY_KEY'] = api_token
    end

    it "should shorten url" do
      UrlShortener.shorten("http://urlmuitolonga.com.br/").should eql("http://j.mp/23")
    end
  end
end
