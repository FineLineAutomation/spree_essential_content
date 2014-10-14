FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_essential_content/factories'
  factory :upload, :class => Spree::Upload do
    attachment { File.new(File.expand_path("../../../spec/factories/1.gif", __FILE__)) }
    alt ""

    trait :gif do
    end

    trait :jpg do
      attachment { File.new(File.expand_path("../../../spec/factories/1.jpg", __FILE__)) }
    end

    trait :png do
      attachment { File.new(File.expand_path("../../../spec/factories/1.png", __FILE__)) }
    end

    trait :pdf do
      attachment { File.new(File.expand_path("../../../spec/factories/test.pdf", __FILE__)) }
    end

    trait :zip do
      attachment { File.new(File.expand_path("../../../spec/factories/test.zip", __FILE__)) }
    end

    factory :invalid_upload do
      attachment nil
    end
  end

  factory :page, :class => Spree::Page do
    sequence(:title) { |n| "Page ##{n}" }
    sequence(:path) { |n| "pages/page-#{n}" }
    nav_title { Faker::Lorem.words.join ' ' }
    meta_title { Faker::Lorem.words.join ' '  }
    meta_description  { Faker::Lorem.sentence }
    meta_keywords  { Faker::Lorem.words.join ',' }
    accessible true
    visible true
  end

  factory :page_image, :class => Spree::PageImage do
    association :viewable, :factory => :page
    attachment { File.new(File.expand_path("../../../spec/factories/1.jpg", __FILE__)) }
  end

  factory :content, :class => Spree::Content do
    association :page, :factory => :page
    sequence(:title) { |n| "Page Content ##{n}" }
    body { Faker::Lorem.paragraphs.join '\n\n' }
    hide_title false
    link ""
    link_text ""
    context ""
    attachment nil
  end

  factory :blog, :class => Spree::Blog do
    name { Faker::Lorem.words.join ' ' }
    permalink { Faker::Lorem.words.join '-' }
  end

  factory :post, :class => Spree::Post do
    association :blog, :factory => :blog
    title { Faker::Lorem.words.join ' ' }
    posted_at { Time.now + rand(10000) }
    body { Faker::Lorem.paragraphs.join '\n\n' }
    tag_list { Faker::Lorem.words.join ',' }
    live true

    trait :past do
      posted_at { Time.now - rand(10000) }
    end
  end

  factory :post_category, :class => Spree::PostCategory do
    name { Faker::Lorem.words.join ' ' }
    permalink ""
  end

  factory :post_image, :class => Spree::PostImage do
    association :viewable, :factory => :post
    attachment { File.new(File.expand_path("../../../spec/factories/1.jpg", __FILE__)) }
  end
end

