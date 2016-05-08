FactoryGirl.define do
  factory :page, class: Spree::Page do
    sequence(:title) { |n| "Page ##{n}" }
    sequence(:path) { |n| "pages/page-#{n}" }
    nav_title { Faker::Lorem.words.join ' ' }
    meta_title { Faker::Lorem.words.join ' '  }
    meta_description  { Faker::Lorem.sentence }
    meta_keywords  { Faker::Lorem.words.join ',' }
    accessible true
    visible true
  end
end