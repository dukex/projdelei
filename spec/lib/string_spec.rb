require File.expand_path('spec/spec_helper')

describe String do
  include Rack::Test::Methods

  describe "#clean" do
    it "should remove html tag"  do
      "<b>Hello Word</b>".clean().should eql("Hello Word")
    end

    it "should remove newline" do
      "Hello\nWord".clean().should eql("Hello Word")
    end

    it "should remove tabulation" do
      "Hello\tWord".clean().should eql("Hello Word")
    end

    it "should remove double space" do
      "Hello  Word".clean().should eql("Hello Word")
    end

    it "should remove last space" do
      "Hello Word ".clean().should eql("Hello Word")
    end
  end

end
