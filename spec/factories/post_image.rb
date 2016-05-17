FactoryGirl.define do
  factory :post_image, class: Spree::PostImage do
    association :viewable, factory: :post
    attachment { File.new(File.expand_path("../../../spec/factories/1.jpg", __FILE__)) }
    alt { Faker::Lorem.words.join ' ' }
  end
end