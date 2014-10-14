require 'spec_helper'

module Spree
  describe Spree::PageImage, type: :model do
    it "is valid with a file" do
      expect(build(:page_image)).to be_valid
    end

    it "is not valid when no file is attached" do
      expect(build(:page_image, attachment: nil)).to_not be_valid
    end
  end
end
