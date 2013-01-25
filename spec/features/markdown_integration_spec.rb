require "spec_helper"

def assert_markdown_renders
  assert_seen "OMG",    :within => "h3"
  assert_seen "item 1", :within => "ul li"
  assert_seen "bold!",  :within => "strong"
  assert_seen "italic", :within => "em"
  expect(has_link?("just a link", :href => "http://example.com")).to eq(true)
end

describe "markdown integration" do

  before(:each) do
    SpreeEssentials.register :example, SpreeEssentialExample
    stub_authorization!
  end
  
  after(:each) do
    SpreeEssentials.essentials.clear
  end
  
  MARKDOWN = <<MD

### OMG

* item 1

**bold!** & _italic_

[just a link](http://example.com)

MD
  
  it "should render have markdown editor and render it's result" do
    visit spree.new_admin_example_path
    fill_in "Title", :with => "Just an example"
    fill_in "Body",  :with => MARKDOWN
	puts body.page
    within ".markItUpHeader" do
      click_link "Preview"
    end    
    within_frame "markItUpPreviewFrame" do
      assert_markdown_renders
    end
    click_button "Create"
    expect(spree.admin_example_path(Spree::Example.last)).to eq(current_path)
    within ".markdown-result" do
      assert_markdown_renders
    end
  end
  
end

