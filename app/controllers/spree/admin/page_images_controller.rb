class Spree::Admin::PageImagesController < Spree::Admin::ResourceController
  before_filter :load_data

  create.before :set_viewable
  update.before :set_viewable
  destroy.before :destroy_before

  private

  def location_after_save
    admin_page_images_url(@page)
  end

  def load_data
    @page ||= Spree::Page.where(path: params[:page_id]).first
  end

  def set_viewable
    @page_image.viewable = @page
  end

  def destroy_before
    @viewable = @page_image.viewable
  end

end
