require File.expand_path('spec/spec_helper')

describe LawProject do
  let(:law) { Factory.build(:law_project) }

  it "should not validate fail url for link" do
    law.link = "google.com"
    law.should_not be_valid
  end

  it "should validate presence of pl_id" do
    Factory.build(:law_project, :pl_id => nil).should_not be_valid
  end

  it "should uniqueness pl_id" do
    law.pl_id = 123
    law.save!
    Factory.build(:law_project, :pl_id => "123").should_not be_valid
  end

  describe ".tweet" do
    before do
      YAML.stub(:load_file).and_return({'api_token' => "", 'user' => "ola" })
      UrlShortener.stub(:shorten).and_return("http://ola.mundo")
    end

    it "should shorten url" do
      law.tweet.should =~ /http:\/\/ola\.mundo/
    end

    it "should have proposition" do
      law.tweet.should =~ Regexp.new(law.proposition)
    end

    it "should have 3 points(...) " do
      law.tweet.should =~ /\.\.\./
    end

    it "should not over 140 char" do
      law.tweet.length.should_not > 140
    end
  end
end
