Spree::PermittedAttributes.class_eval do
  ATTRIBUTES.push(:blog_attributes, :content_attributes, :page_attributes, :page_image_attributes, :post_attributes,
                 :post_category_attributes, :post_image_attributes, :post_product_attributes, :upload_attributes)

  @@blog_attributes= [:name, :permalink]

  @@content_attributes = [:page_id, :title, :body, :hide_title, :link, :link_text, :context,
                          :attachment, :delete_attachment]

  @@page_attibutes = [:title, :path, :nav_title, :meta_title, :meta_description, :meta_keywords,
                      :accessible, :visible]

  @@page_image_attributes = [:viewable, :attachment, :alt]

  @@post_attributes = [:blog_id, :title, :teaser, :body, :posted_at, :author, :live, :tag_list,
                       :post_category_ids, :product_ids_string]

  @@post_category_attributes = [:name, :permalink]

  @@post_image_attributes = [:alt, :attachment]

  @@post_product_attributes = [:post_id, :product_id, :position]

  @@upload_attributes = [:attachment, :alt]
end
