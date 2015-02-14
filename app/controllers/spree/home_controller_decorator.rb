Spree::HomeController.class_eval do
  before_filter :get_homepage

  helper 'spree/blogs/posts'

  def index
    @searcher = build_searcher(params.merge(include_images: true))
    @products = @searcher.retrieve_products.limit(8)
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    render :template => "spree/pages/home"
  end

  private

    def get_homepage
      @page = Spree::Page.find_by_path("/")
      @posts = Spree::Post.web.limit(5)
    end

    def accurate_title
      @page.meta_title unless @page.nil?
    end

end
