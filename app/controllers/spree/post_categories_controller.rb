module Spree
  class PostCategoriesController < StoreController

    helper 'spree/blogs/posts'

    before_filter :get_blog
    before_filter :get_sidebar, only: [:index, :search, :show]

    def show
      @category = Spree::PostCategory.find_by_permalink(params[:id])
      return if @category.nil?
      @posts = @category.posts.live
      @posts = @posts.page(params[:page]).per(Spree::Post.per_page)
      @breadcrumbs = [
        [@posts[0].blog.name, "/#{@posts[0].blog.permalink}"],
        ["Category - #{@category.name}", "/#{@posts[0].blog.permalink}/category/#{@category.permalink}"]
      ]
    end

  private

    def default_scope
      @blog.posts.live
    end

    def get_sidebar
      @archive_posts = default_scope.web
      @post_categories = @blog.categories.order(:name).all
      get_tags
    end

    def get_tags
      @tags = default_scope.web.tag_counts.order('count DESC').limit(25)
    end

    def get_blog
      @blog = Spree::Blog.find_by_permalink!(Spree::Blog.normalize_permalink(params[:blog_id]))
    end

  end
end
