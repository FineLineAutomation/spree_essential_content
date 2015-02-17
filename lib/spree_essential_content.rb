require 'spree_core'
require "acts-as-taggable-on"

require 'spree_essential_content/engine'

module Spree
  class PossiblePage
    def self.matches?(request)
      return false if request.path =~ Spree::Page::RESERVED_PATHS
      Spree::Page.active.where(path: Spree::Page.normalize_path(request.path)).any?
    end
  end

  class PossibleBlog
    def self.matches?(request)
      return false if request.path =~ Spree::Blog::RESERVED_PATHS
      Spree::Blog.where(permalink: Spree::Blog.normalize_permalink(request.path)).any?
    end
  end
end