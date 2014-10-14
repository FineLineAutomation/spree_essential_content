require 'spec_helper'

describe Spree::Upload, type: :model do
  describe 'has_alt' do
    it "returns true when alt is not blank" do
      expect(create(:upload, alt: "omg").has_alt?).to eq(true)
    end

    it "returns false when alt is blank" do
      expect(create(:upload).has_alt?).to eq(false)
    end
  end

  it "has an attached file" do
    have_attached_file(:attachment)
  end

  it "is not valid without a component variant" do
    expect(build(:upload, attachment: nil)).to_not be_valid
  end

  it "is valid with a attachment" do
    expect(build(:upload)).to be_valid
  end

  it "returns image content for gif files" do
    expect(create(:upload, :gif).image_content?).to_not be_nil
  end

  it "returns image content for jpg files" do
    expect(create(:upload, :jpg).image_content?).to_not be_nil
  end

  it "returns image content for png files" do
    expect(create(:upload, :png).image_content?).to_not be_nil
  end

  it "does not return image content for pdf files" do
    expect(create(:upload, :pdf).image_content?).to be_nil
  end

  it "does not return image content for zip files" do
    expect(create(:upload, :zip).image_content?).to be_nil
  end
end
