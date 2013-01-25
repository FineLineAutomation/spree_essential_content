require "spec_helper"

describe "upload integration" do
  
  before(:each) do
    Spree::Upload.destroy_all
    @image  = File.expand_path("../../support/files/1.png", __FILE__)
    @image2 = File.expand_path("../../support/files/2.png", __FILE__)
    stub_authorization!
  end
  
  it "should have a contents tab" do
    visit spree.admin_orders_path
    within "#admin-menu" do
      expect(has_link?("Content")).to eq(true)
    end
  end
  
  it "should get the uploads index" do
    visit spree.admin_uploads_path
    assert has_link?("new_image_link")
    within "#sub_nav" do
      expect(has_link?("Uploads", :href => spree.admin_uploads_path)).to eq(true)
    end
  end
  
  it "should paginate the uploads index" do
    Spree::Config.set(:orders_per_page => 2)
    img = File.open(@image)
    3.times { |i|
      Spree::Upload.create(:attachment => img, :alt => "sample #{i + 1}")
    }  
    visit spree.admin_uploads_path
    within ".pagination" do
      expect(has_link?("2")).to eq(true)
      click_link "2"
    end
    assert_seen "sample 3", :within => "table.index"
    assert_match /page\=2/, current_url
  end
  
  it "should create an upload" do
    visit spree.admin_uploads_path
    click_link "new_image_link"
    attach_file "Attachment", @image
    fill_in "Description", :with => "Just an image"
    click_button "Create"
    expect(spree.admin_uploads_path).to eq(current_path)
    assert_flash :notice, "Upload has been successfully created!"
  end
  
  context "with an existing upload" do
    before(:each) do 
      @upload = Spree::Upload.create(:attachment => File.open(@image), :alt => "Just an image!")
    end
  
    it "should display the index" do
      visit spree.admin_uploads_path
      expect(has_link?("1.png", :href => @upload.attachment.url(:original))).to eq(true)
	  puts page.body
      assert_seen "Just an image!", :within => "tr#upload_#{@upload.id}"
      within "td.actions" do
        expect(find("a.icon_link").native.attribute("href").include?(spree.edit_admin_upload_path(@upload))).to eq(true)
        expect(has_selector?("a.delete-resource")).to eq(true)
      end
    end
    
    it "should edit the upload" do
      visit spree.edit_admin_upload_path(@upload)
      assert_seen "Preview", :within => ".edit_upload p b"
      expect(has_xpath?("//img[@src='#{@upload.attachment.url(:small)}']")).to eq(true)
      attach_file "Attachment", @image2
      fill_in "Description", :with => "Just another image"
      click_button "Update"
      expect(spree.admin_uploads_path).to eq(current_path)
      assert_flash :notice, "Upload has been successfully updated!"
    end
  
    it "should destroy the upload" do
      visit spree.admin_uploads_path
      find("a.delete-resource").click
      page.driver.browser.switch_to.alert.accept
      assert_seen "Upload has been successfully removed!"
    end
    
  end
  
end
