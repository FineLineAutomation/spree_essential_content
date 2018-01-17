FactoryGirl.define do
  factory :page, class: Spree::Page do
    sequence(:title) { |n| "Page ##{n}" }
    sequence(:path) { |n| "pages/page-#{n}" }
    nav_title { FFaker::Lorem.words.join ' ' }
    meta_title { FFaker::Lorem.words.join ' '  }
    meta_description  { FFaker::Lorem.sentence }
    meta_keywords  { FFaker::Lorem.words.join ',' }
    accessible true
    visible true
  end
end
