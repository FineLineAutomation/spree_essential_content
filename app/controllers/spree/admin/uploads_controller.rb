module Spree
  module Admin
    class UploadsController < ResourceController
      private

        def find_resource
          @upload ||= Spree::Upload.find_by_id(params[:id])
        end

        def collection
          return @collection if @collection.present?
          params[:q] ||= {}
          params[:q][:s] ||= "attachment_updated_at desc"
          @search = Spree::Upload.search(params[:q])
          @collection = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])
        end
    end
  end
end
