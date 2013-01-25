require 'spec_helper'

describe "extensions" do
    
  before(:each) do
    SpreeEssentials.essentials.clear
  end  
  
  it "should have a hash as it's tab" do
    tab = { :label => "Examples", :route => "admin_examples" }
    expect(SpreeEssentialExample.tab).to eq(tab)
  end
  
  it "should have an array as it's subtab" do
    sub_tab = [ :examples, { :match_path => '/examples' }]
    expect(SpreeEssentialExample.sub_tab).to eq(sub_tab)
  end
  
  it "should start with zero essentials" do
    expect(SpreeEssentials.essentials.length ).to eq(0)
  end
  
  it "should register an essential" do
    SpreeEssentials.register :example, SpreeEssentialExample
    expect(SpreeEssentials.essentials.length).to eq(1)
  end
      
  it "should check if spree essentials has an extension" do
    SpreeEssentials.register :example, SpreeEssentialExample
    expect(SpreeEssentials.has?(:example)).to eq(true)
  end
  
end
