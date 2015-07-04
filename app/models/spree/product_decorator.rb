Spree::Product.class_eval do
  has_many :post_products
  has_many :posts, through: :post_products
end
