FactoryGirl.define do
  factory :post_product, class: Spree::PostProduct do
    association :post, factory: :post
    association :product, factory: :product
  end
end

