class Spree::PostProduct < ActiveRecord::Base
  acts_as_list

  belongs_to :post
  belongs_to :product

  validates :post_id, presence: true
  validates :product_id, presence: true
  validate :product_is_not_already_assigned_to_post, if: lambda { !post_id.nil? and !product_id.nil? }

  def product_is_not_already_assigned_to_post
    product_scope = Spree::PostProduct.where(post_id: post.id).where(product_id: product.id)
    if !id.nil?
      product_scope = product_scope.where("id != ?", id)
    end

    if !product_scope.first.nil?
      errors.add(:product_id, "is already assigned to the post and cannot be added twice.")
    end
  end
end
