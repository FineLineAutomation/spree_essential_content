FactoryGirl.define do
  factory :post_category, class: Spree::PostCategory do
    name { Faker::Lorem.words.join ' ' }
    permalink ""
  end
end