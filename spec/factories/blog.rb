FactoryGirl.define do
  factory :blog, class: Spree::Blog do
    name { FFaker::Lorem.words.join ' ' }
    permalink { FFaker::Lorem.words.join '-' }
  end
end
