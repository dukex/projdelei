require File.expand_path('spec/spec_helper')

describe Updater do
  before do
    FakeWeb.register_uri :get, %r|http:\/\/api\.j\.mp\/v3\/shorten*|, :body => "http://j.mp/ola"
    YAML.stub(:load_file).and_return({'api_token' => "", 'user' => "ola" })

    Twitter.stub(:update) { true }
  end

  describe "#run" do
    it "should get last Law Project with was_shared false" do
      Factory :law_project, :was_shared => false, :pl_id => 2
      5.times {|i| Factory :law_project, :was_shared => true, :pl_id => i+3 }
      4.times {|i| Factory :law_project, :was_shared => true, :pl_id => i+8 }
      Updater.now
      LawProject.first(:pl_id => 2).was_shared.should be_true
    end

    it "should update law like was share true" do
      Factory :law_project, :was_shared => false
      Updater.now
      LawProject.last.was_shared.should be_true
    end

    it "should call update of Twitter" do
      law = Factory :law_project
      Twitter.should_receive(:update).with(law.tweet)
      Updater.now
    end
  end



end
