module Spree
  class PostsController < StoreController
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    helper 'spree/blogs/posts'
    helper "spree/products"

    before_filter :get_blog
    before_filter :get_sidebar, only: [:index, :search, :show]

    def index
      @posts_by_month = default_scope.web.limit(50).group_by { |post| post.posted_at.strftime("%B %Y") }
      scope = default_scope.web
      @breadcrumbs = [ [@blog.name, "/#{@blog.permalink}"] ]
      @title = "#{@blog.name}"
      if params[:year].present?
        @title = "#{@title} for"
        @breadcrumbs << [params[:year], "/#{@blog.permalink}/#{params[:year].to_i}"]
        year  = params[:year].to_i
        month = 1
        day   = 1
        if has_month = params[:month].present?
          @title = "#{@title} #{Date::MONTHNAMES[params[:month].to_i]}, "
          @breadcrumbs << [Date::MONTHNAMES[params[:month].to_i], "/#{@blog.permalink}/#{params[:year].to_i}/#{params[:month].to_i}"]
          if has_day = params[:day].present?
            day  = params[:day].to_i
          end
          month = params[:month].to_i
        end
        start = Date.new(year, month, day)
        stop  = start + 1.year
        if has_month
          stop = start + 1.month
          if has_day
            stop = start + 1.day
          end
        end
        scope = scope.where("posted_at >= ? AND posted_at <= ?", start, stop)
        @title = "#{@title} #{params[:year]}"
      end
      @posts = scope.page(params[:page]).per(Spree::Post.per_page)
    end

    def search
      query = params[:query].gsub(/%46/, '.')
      @posts = default_scope.web.tagged_with(query).page(params[:page]).per(Spree::Post.per_page)
      @breadcrumbs = [
        [@blog.name, "/#{@blog.permalink}"],
        ["Tags - #{query}", "#{request.protocol}#{request.host_with_port}#{request.fullpath}"]
      ]
      @title = "#{@blog.name} tagged with '#{query}'"
      get_tags
      render template: 'spree/posts/index'
    end

    def show
      @post = default_scope.web.includes(:tags, :images, :products).find_by_path(params[:id]) rescue nil
      if !@post.nil?
        @breadcrumbs = [
          [@blog.name, "/#{@blog.permalink}"],
          [@post.posted_at.year, "/#{@blog.permalink}/#{@post.posted_at.year}"],
          [@post.posted_at.strftime("%B"), "/#{@blog.permalink}/#{@post.posted_at.year}/#{@post.posted_at.month}"],
          [@post.title, spree.full_post_path(@blog, @post.year, @post.month, @post.day, @post.to_param)]
        ]
      else
        @breadcrumbs = []
      end

      return redirect_to blog_posts_path unless @post
    end

    def archive
      redirect_to blog_posts_path
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
