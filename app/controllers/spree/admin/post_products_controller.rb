module Spree
  module Admin
    class PostProductsController < ResourceController

      before_filter :load_data
      create.before :set_post_and_product

      def set_post_and_product
        params[:post_product][:product_id] = Spree::Variant.find(params[:post_product][:product_id]).product.id
        @post_product.post = @post
      end

      private

      def location_after_save
        admin_post_products_url(@post)
      end

      def load_data
        @post = Spree::Post.find_by_path(params[:post_id])
      end
    end
  end
end
