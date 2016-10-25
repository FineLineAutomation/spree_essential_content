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

      def location_after_save
        admin_pages_url
      end

      private
        def find_resource
          @object ||= Spree::Page.where(path: params[:id]).first
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