class Spree::PagesController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  helper 'spree/blogs/posts'
  helper 'spree/products'

  def show
    @page = current_page
    raise ActionController::RoutingError.new("No route matches [GET] #{request.path}") if @page.nil?
    if @page.root?
      @posts = Spree::Post.live.limit(5)
      render template: 'spree/pages/home'
    end
  end

  private
    def accurate_title
      @page.meta_title
    end
end
