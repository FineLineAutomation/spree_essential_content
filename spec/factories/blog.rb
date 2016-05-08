FactoryGirl.define do
  factory :blog, class: Spree::Blog do
    name { Faker::Lorem.words.join ' ' }
    permalink { Faker::Lorem.words.join '-' }
  end
end
