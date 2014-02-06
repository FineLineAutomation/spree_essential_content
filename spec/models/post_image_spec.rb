require 'spec_helper'

module Spree
  describe Spree::PostImage do
    it "is valid with a file" do
      expect(build(:post_image)).to be_valid
    end

    it "is not valid when no file is attached" do
      expect(build(:post_image, :attachment => nil)).to_not be_valid
    end
  end
end