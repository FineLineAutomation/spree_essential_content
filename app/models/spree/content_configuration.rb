class Spree::ContentConfiguration < Spree::Preferences::Configuration
  preference :disqus_shortname, :string, default: ''
  preference :sharethis_publisher_id, :string, default: ''

  preference :show_posts_on_homepage, :boolean, default: true
  preference :show_products_on_homepage, :boolean, default: true
  preference :show_taxons_on_homepage, :boolean, default: true
end
