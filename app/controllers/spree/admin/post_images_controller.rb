module Spree
  module Admin
    class PostImagesController < ResourceController

      before_filter :load_data

      create.before :set_viewable
      update.before :set_viewable
      destroy.before :destroy_before

      private

      def location_after_save
        admin_post_images_url(@post)
      end

      def load_data
        @post = Spree::Post.find_by_path(params[:post_id])
      end

      def set_viewable
        @post_image.viewable = @post
      end

      def destroy_before
        @viewable = @post_image.viewable
      end

    end
  end
end
