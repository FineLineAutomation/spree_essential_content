class Spree::PostImage < Spree::Asset

  has_attached_file :attachment,
    styles: Proc.new{ |clip| clip.instance.attachment_sizes },
    url: '/spree/posts/:id/:style/:basename.:extension',
    path: ':rails_root/public/spree/posts/:id/:style/:basename.:extension'

  validates_attachment_content_type :attachment, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_presence :attachment

  def image_content?
    attachment_content_type.to_s.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end
  
  def attachment_sizes
    hash = {}
    hash.merge!(mini: '48x48>', small: '150x150>', medium: '600x600>', large: '950x700>') if image_content?
    hash
  end
    
end
