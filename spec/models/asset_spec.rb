require 'spec_helper'

describe Spree::Asset do

  before(:each) do
    @asset = Spree::Asset.new
  end

  it "should return true if asset has_alt?" do
    @asset.alt = "omg"
    expect(@asset.has_alt?).to eq(true)
  end
  
  it "should return false unless asset has_alt?" do
    expect(@asset.has_alt?).to eq(false)
  end
  
end
