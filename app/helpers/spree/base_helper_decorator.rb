module Spree
  module BaseHelper
    def content_snippets
      Spree::Page.where(title: "Content Snippets").first
    end
  end
end
