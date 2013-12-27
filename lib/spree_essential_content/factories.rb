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
  end
end
