class Spree::Upload < Spree::Asset
  validate :no_attachment_errors

  after_initialize do
    if has_attribute?(:whitelisted_ransackable_attributes)
      self.whitelisted_ransackable_attributes = ['alt', 'attachment_file_name']
    end
  end

  has_attached_file :attachment,
    styles:        Proc.new{ |clip| clip.instance.attachment_sizes },
    default_style: :medium,
    url:           "/spree/uploads/:id/:style/:basename.:extension",
    path:          ":rails_root/public/spree/uploads/:id/:style/:basename.:extension"

  do_not_validate_attachment_file_type :attachment

  def image_content?
    attachment_content_type.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end

  def attachment_sizes
    if image_content?
      { mini: '48x48>', small: '150x150>', medium: '420x300>', large: '800x500>' }
    else
      {}
    end
  end

  # if there are errors from the plugin, then add a more meaningful message
  def no_attachment_errors
    unless attachment.errors.empty? and !attachment_file_name.blank?
      # uncomment this to get rid of the less-than-useful interrim messages
      # errors.clear
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end

  def has_alt?
    alt.present?
  end
end
