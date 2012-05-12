require 'spec_helper'

describe AppConfig do
  before { AppConfig.clear! }
  
  context "#[]" do
    subject { AppConfig[:application] }
    it { should be_a_kind_of(Hash) }
    
    context "with string as key" do
      subject { AppConfig["application"]["some_var"] }
      it { should == "Something more" }
    end
    
    context "with symbol as key" do
      subject { AppConfig[:application][:some_var] }
      it { should == "Something more" }
    end
  end
  
  context "different environments" do
    context "development" do
      before { Rails.env = "development" }
      subject { AppConfig[:application][:some_var] }
      it { should == "Some value" }
    end
    
    context "production" do
      before { Rails.env = "production" }
      subject { AppConfig[:application][:some_var] }
      it { should == "Something else" }
    end
  end
  
end