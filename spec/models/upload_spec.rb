require 'spec_helper'

describe Spree::Upload do

  before(:each) do
    Spree::Upload.destroy_all
	#puts File.expand_path("../../support/files/*.jpg", __FILE__)
    @jpgs = Dir[File.expand_path("../../support/files/*.jpg", __FILE__)]
    @pngs = Dir[File.expand_path("../../support/files/*.png", __FILE__)]
    @gifs = Dir[File.expand_path("../../support/files/*.gif", __FILE__)]
  end
  
  it "should have attached file" do
	have_attached_file(:attachment)
  end
  
  it "should validate attachment" do
    upload = Spree::Upload.new
	expect(!upload.valid?).to eq(true)
    expect(!upload.save).to eq(true)
  end
  
  it "should create an upload" do
    upload = Spree::Upload.new(:attachment => File.open(File.expand_path(@jpgs.shuffle.first)))
    expect(upload.valid?).to eq(true)
	upload_count = Spree::Upload.count
    expect(upload.save).to eq(true)
	expect(Spree::Upload.count).to eq(upload_count+1)
  end
  
  context "with an existing upload" do 
    
    before(:each) do
      @jpg = Spree::Upload.create(:alt => "jpg", :attachment => File.open(File.expand_path(@jpgs.shuffle.first)))
      @png = Spree::Upload.create(:alt => "png", :attachment => File.open(File.expand_path(@pngs.shuffle.first)))
      @gif = Spree::Upload.create(:alt => "gif", :attachment => File.open(File.expand_path(@gifs.shuffle.first)))
      @pdf = Spree::Upload.create(:alt => "pdf", :attachment => File.open(File.expand_path("../../support/files/test.pdf", __FILE__)))
      @zip = Spree::Upload.create(:alt => "zip", :attachment => File.open(File.expand_path("../../support/files/test.zip", __FILE__)))
    end
    
    it "should be image content" do
      [@jpg, @png, @gif].each do |upload|
        expect(upload.image_content?).not_to be_nil
      end
    end
    
    it "should not be image content" do
      [@pdf, @zip].each do |upload|
        expect(upload.image_content?).to be_nil
      end
    end
    
  end
    
end