require 'spec_helper'

describe Spree::Blog, type: :model do
  it "is valid with a name and permalink" do
    expect(build(:blog)).to be_valid
  end

  it "is not valid when name is blank" do
    expect(build(:blog, name: '')).to_not be_valid
  end

  it "is not valid when permalink is not unique" do
    blog = create(:blog)
    expect(build(:blog, permalink: blog.permalink)).to_not be_valid
  end

  it "is not valid when permalink is a reserved path" do
    expect(build(:blog, permalink: "cart")).to_not be_valid
  end

  it "automatically creates a permalink based on the name" do
    expect(create(:blog, name: 'This should parameterize', permalink: "").permalink).to eq("this-should-parameterize")
  end

  it "formats the permalink to all downcase" do
    expect(create(:blog, permalink: "Testing-DoWnCaSe").permalink).to eq("testing-downcase")
  end

  it "formats the permalink to remove leading and trailing slashes" do
    expect(create(:blog, permalink: "/test-slashes/").permalink).to eq("test-slashes")
  end
end
