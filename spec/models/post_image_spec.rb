require 'spec_helper'

describe Spree::PostImage, type: :model do
  it "is valid with a file" do
    expect(build(:post_image)).to be_valid
  end

  it "is not valid when no file is attached" do
    expect(build(:post_image, attachment: nil)).to_not be_valid
  end
end
