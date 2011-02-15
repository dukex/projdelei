require File.expand_path('spec/spec_helper')

describe Law do
  let(:law) { Factory.build(:law) }

  it "should not validate fail url for link" do
    law.link = "google.com"
    law.should_not be_valid
  end

  it "should uniqueness pl_id" do
    law.pl_id = 123
    law.save!
    Factory.build(:law, :pl_id => "123").should_not be_valid
  end

end
