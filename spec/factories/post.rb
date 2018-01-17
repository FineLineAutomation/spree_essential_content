FactoryGirl.define do
  factory :post, class: Spree::Post do
    association :blog, factory: :blog
    title { FFaker::Lorem.words.join ' ' }
    posted_at { Time.now + rand(10000) }
    body { FFaker::Lorem.paragraphs.join '\n\n' }
    tag_list { FFaker::Lorem.words.join ',' }
    live true

    trait :past do
      posted_at { Time.now - rand(10000) }
    end
  end
end
