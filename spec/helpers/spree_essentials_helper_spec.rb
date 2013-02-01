require 'spec_helper'
require 'helpers_spec_helper'

describe Spree::Admin::SpreeEssentialsHelper do

  before(:each) do
	SpreeEssentials.essentials.clear
    setup_with_controller
    visit "/admin"
  end

  it "should build admin contents tab" do
    expect(helper.contents_tab).to eq("<li><a href=\"/admin/uploads\">Content</a></li>")
  end

  it "should add selected class to admin contents tab" do
    visit "/admin/uploads"
    expect(helper.contents_tab).to eq("<li class=\"selected\"><a href=\"/admin/uploads\">Content</a></li>")
  end

  it "should have markdown helper link" do
    expect(helper.markdown_helper).to eq("<em class=\"small markdown-helper\">Parsed With <a href=\"http://daringfireball.net/projects/markdown/basics\" onclick=\"window.open(this.href); return false\">Markdown</a></em>")
  end

end
