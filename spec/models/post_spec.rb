require 'spec_helper'

describe Spree::Post, type: :model do
  it "is valid with a title and body" do
    expect(build(:post)).to be_valid
  end

  it "is not valid when title is blank" do
    expect(build(:post, title: '')).to_not be_valid
  end

  it "is not valid when body is blank" do
    expect(build(:post, body: '')).to_not be_valid
  end

  it "is not valid when the date is not valid" do
    expect(build(:post, posted_at: 'testing')).to_not be_valid
  end

  it "automatically sets the path" do
    expect(create(:post, title: 'This should parameterize').path).to eq("this-should-parameterize")
  end

  it "increments the path when it already exists" do
    create(:post, title: 'This should parameterize')
    expect(create(:post, title: 'This should parameterize').path).to eq("this-should-parameterize-2")
  end

  context "when filtering with the live scope" do
    it "contains posts that are live" do
      post = create(:post)
      expect(Spree::Post.live).to include(post)
    end

    it "does not contain posts that are not live" do
      post = create(:post, live: false)
      expect(Spree::Post.live).to_not include(post)
    end
  end

  context "when filtering with the future scope" do
    it "contains posts that are in the future" do
      post = create(:post, posted_at: Time.now + 1.hour)
      expect(Spree::Post.future).to include(post)
    end

    it "does not contain posts that are not in the future" do
      post = create(:post, posted_at: Time.now - 1.hour)
      expect(Spree::Post.future).to_not include(post)
    end
  end

  context "when filtering with the past scope" do
    it "contains posts that are in the past" do
      post = create(:post, posted_at: Time.now - 1.hour)
      expect(Spree::Post.past).to include(post)
    end

    it "does not contain posts that are not in the past" do
      post = create(:post, posted_at: Time.now + 1.hour)
      expect(Spree::Post.past).to_not include(post)
    end
  end

  context "when ordering with the ordered scope" do
    it "orders posts by latest posts first" do
      post = create(:post, posted_at: Time.now - 1.hour)
      post2 = create(:post, posted_at: Time.now + 1.hour)
      expect(Spree::Post.ordered).to eq([post2, post])
    end
  end

  context "when filtering with the web scope" do
    it "contains posts that are in the past" do
      post = create(:post, posted_at: Time.now - 1.hour)
      expect(Spree::Post.web).to include(post)
    end

    it "does not contain posts that are in the future" do
      post = create(:post, posted_at: Time.now + 1.hour)
      expect(Spree::Post.web).to_not include(post)
    end

    it "contains posts that are live" do
      post = create(:post, :past)
      expect(Spree::Post.web).to include(post)
    end

    it "does not contain posts that are not live" do
      post = create(:post, :past, live: false)
      expect(Spree::Post.web).to_not include(post)
    end

    it "orders posts by latest posts first" do
      post = create(:post, posted_at: Time.now - 2.hours)
      post2 = create(:post, posted_at: Time.now - 1.hour)
      expect(Spree::Post.ordered).to eq([post2, post])
    end
  end
end
