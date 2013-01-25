require "spec_helper"

describe "extension integration" do
  
  before(:each) do
    SpreeEssentials.essentials.clear
    stub_authorization!
  end
  
  context "When no extensions are registered" do
    it "should have a contents tab with only uploads in the sub nav" do
      visit spree.admin_orders_path
      within "#admin-menu" do
        expect(has_link?("Content")).to eq(true)
      end
      click_link "Content"
      within "#sub-menu" do
        expect(has_link?("Uploads")).to eq(true)
      end
      expect(has_css?("#sub-menu li", :count => 1)).to eq(true)
    end
  
  end
  
  context "When an extension is registered" do
    
    before(:each) do
      SpreeEssentials.register :example, SpreeEssentialExample
    end
    
    after(:each) do
      SpreeEssentials.essentials.clear
    end
    
    it "should have a contents tab with examples and uploads in the sub nav" do
      visit spree.admin_orders_path
      within "#admin-menu" do
        expect(has_link?("Content")).to eq(true)
      end
      click_link "Content"
      within "#sub-menu" do
        expect(has_link?("Examples")).to eq(true)
        expect(has_link?("Uploads")).to eq(true)
      end
      expect(has_css?("#sub-menu li", :count => 2)).to eq(true)
    end
    
  end
  
end
