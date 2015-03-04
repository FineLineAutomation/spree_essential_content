module Spree
  module Admin
    class PagesController < ResourceController
      def location_after_save
        case params[:action]
          when "create"
            edit_admin_page_content_path(@page, @page.contents.first)
          else
            admin_page_path(@page)
        end
      end

      def update_positions
        params[:positions].each do |id, index|
          Spree::Page.update_all(['position=?', index], ['id=?', id])
        end
        respond_to do |format|
          format.html { redirect_to admin_pages_path }
          format.js  { render text: 'Ok' }
        end
      end

      private
        def find_resource
          Spree::Page.find_by_path(params[:id])
        end

        def collection
          params[:q] ||= {}
          params[:q][:s] ||= "position asc"
          @search = Spree::Page.search(params[:q])
          @collection = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])
        end
    end
  end
end