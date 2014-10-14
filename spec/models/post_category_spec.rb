require 'spec_helper'

module Spree
  describe Spree::PostCategory, type: :model do
    it "is valid with a name and permalink" do
      expect(build(:post_category)).to be_valid
    end

    it "is not valid when name is blank" do
      expect(build(:post_category, name: '')).to_not be_valid
    end

    it "is not valid when permalink is not unique" do
      post_category = create(:post_category)
      expect(build(:post_category, permalink: post_category.permalink)).to_not be_valid
    end

    it "automatically creates a permalink based on the name" do
      expect(create(:post_category, name: 'This should parameterize').permalink).to eq("this-should-parameterize")
    end

    it "increments the permalink when it already exists" do
      create(:post_category, name: 'This should parameterize')
      expect(create(:post_category, name: 'This should parameterize').permalink).to eq("this-should-parameterize-2")
    end
  end
end
