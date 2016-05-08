FactoryGirl.define do
  factory :post, class: Spree::Post do
    association :blog, factory: :blog
    title { Faker::Lorem.words.join ' ' }
    posted_at { Time.now + rand(10000) }
    body { Faker::Lorem.paragraphs.join '\n\n' }
    tag_list { Faker::Lorem.words.join ',' }
    live true

    trait :past do
      posted_at { Time.now - rand(10000) }
    end
  end
end