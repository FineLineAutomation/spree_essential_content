FactoryGirl.define do
  factory :content, class: Spree::Content do
    association :page, factory: :page
    sequence(:title) { |n| "Page Content ##{n}" }
    body { FFaker::Lorem.paragraphs.join '\n\n' }
    hide_title false
    link ""
    link_text ""
    context ""
    attachment nil
  end
end
