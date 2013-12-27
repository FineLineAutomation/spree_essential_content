FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_essential_content/factories'
  factory :upload, :class => Spree::Upload do
    attachment { File.new(File.expand_path("../../../spec/factories/1.gif", __FILE__)) }
    alt ""
  end
end
