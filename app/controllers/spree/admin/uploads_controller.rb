class Spree::Admin::UploadsController < Spree::Admin::ResourceController
  def collection
    super.order(:attachment_updated_at)
  end
end
