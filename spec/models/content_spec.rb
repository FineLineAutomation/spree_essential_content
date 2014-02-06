require 'spec_helper'

module Spree
  describe Spree::Content do
    it "is valid with a page and title" do
      expect(build(:content)).to be_valid
    end

    it "is not valid when page is blank" do
      expect(build(:content, :page => nil)).to_not be_valid
    end

    it "is not valid when title is blank" do
      expect(build(:content, :title => '')).to_not be_valid
    end
  end
end