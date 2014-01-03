module Spree
  class PostCategoriesController < StoreController

    include SpreeEssentialBlog::PostsControllerHelper

    before_filter :get_sidebar, :only => [:index, :search, :show]

    def show
      @category = Spree::PostCategory.find_by_permalink(params[:id])
      @posts = @category.posts.live
      @posts = @posts.page(params[:page]).per(Spree::Post.per_page)
      @breadcrumbs = [
        [@posts[0].blog.name, "/#{@posts[0].blog.permalink}"],
        ["Category - #{@category.name}", "/#{@posts[0].blog.permalink}/category/#{@category.permalink}"]
      ]
    end

  end
end