FactoryGirl.define do
  factory :post_category, class: Spree::PostCategory do
    name { FFaker::Lorem.words.join ' ' }
    permalink ""
  end
end
