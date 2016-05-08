FactoryGirl.define do
  factory :page_image, class: Spree::PageImage do
    association :viewable, factory: :page
    attachment { File.new(File.expand_path("../../../spec/factories/1.jpg", __FILE__)) }
  end
end