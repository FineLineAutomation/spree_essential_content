require 'spec_helper'

describe Spree::PostProduct, type: :model do
  it "is valid with a post and product" do
    expect(build(:post_product)).to be_valid
  end

  it "is not valid when not assigned to a post" do
    expect(build(:post_product, post_id: nil)).to_not be_valid
  end

  it "is not valid when not assigned to a product" do
    expect(build(:post_product, product_id: nil)).to_not be_valid
  end

  it "is not valid when the product is already assigned to a post" do
    post_product = create(:post_product)
    expect(build(:post_product, post_id: post_product.post.id, product_id: post_product.product.id)).to_not be_valid
  end
end
