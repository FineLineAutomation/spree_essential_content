FactoryGirl.define do
  factory :upload, class: Spree::Upload do
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
end